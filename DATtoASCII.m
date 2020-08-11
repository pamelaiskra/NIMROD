function DATtoASCII

%{
This function reads radar rainfall from BADC and writes ASCII files
1) First, it renames the files to radar_rainfall_fileNNNN.dat to use the 
function in a loop. Files must be in chronological order.
BE CAREFUL because renaming is an irreversible process.
2) Then it creates a header 'Header' for an ASCII file.
3) After that, it uses the function 'readBADC' to read each *.dat file
and obtain a matrix with the rainfall information 'rr_dat_mat'
4) Finally it appends the rain matrix 'rr_dat_mat' from each file to the
header and exports each file into a *.txt
5) Is writes a .txt file with the original and the new filenames for
reference.

AUTHOR of the DATtoASCII function: P Iskra Mejia Estrada
INSTITUTION: University of Bristol
DATE: 09-08-2016
TITLE: Reading binary data file from Nimrod database on BADC (British
Atmospheric Data Centre)

AUTHOR of the nested function readBADC: Chethana Nagaraja
INSTITUTION: University of Glamorgan
DATE: 14-12-2007
TITLE: Reading binary data file from Nimrod database on BADC (British
Atmospheric Data Centre)
%}

% Rename files
myPath=pwd;
files = dir('metoffice*.dat');
num_files = length(files(not([files.isdir])));
fprintf('Files to process = %d\n* * * *',num_files);
fileNames = { files.name };
fileID = fopen('ListOfRenamedFiles.txt','a');
c=datestr(now);
fprintf(fileID,'\n\nYour modified filenames list on %s is:\n',c);
fprintf(fileID,'Original filename\t\t\t\t\t\tNew filename\n');
formatSpec = '%s | %s\n';
for iFile = 1 : numel( files )
    
%{
--------------------------------
    % Plot and write *.jpg files for every *.dat file read
loc_easting = 428581.671111;
loc_northing = 562040.407245;
plot(loc_easting,loc_northing,'Xr'); % "X" mark for reference

scrsz = get(0,'ScreenSize');
fh1 = figure('OuterPosition',[1 scrsz(4)*.05 scrsz(3)*0.5 scrsz(4)* 0.95]);
% Change colour limits for image and colourbar as needed 
% Values are 1/32 mm/hr so 500=15.63 mm/hr
clims = [ 0 500 ];
xg = linspace(rl_datsp_hd(2),rl_datsp_hd(4),int_gen_hd(19));
yg = linspace(rl_datsp_hd(1),rl_datsp_hd(5),int_gen_hd(18));
imagesc(xg,yg,rr_dat_mat,clims);
ax=gca;
    Rainfall_colourmap1=[1,1,1;0.980130732059479,0.985359489917755,1;0.960261464118958,0.970718979835510,1;0.940392136573792,0.956078410148621,1;0.920522868633270,0.941437900066376,1;0.900653600692749,0.926797389984131,1;0.880784332752228,0.912156879901886,1;0.860915064811707,0.897516369819641,1;0.841045737266541,0.882875800132752,1;0.821176469326019,0.868235290050507,1;0.801307201385498,0.853594779968262,1;0.781437933444977,0.838954269886017,1;0.761568665504456,0.824313759803772,1;0.741699337959290,0.809673190116882,1;0.721830070018768,0.795032680034638,1;0.701960802078247,0.780392169952393,1;0.688970625400543,0.767647087574005,0.990604579448700;0.675980389118195,0.754901945590973,0.981209158897400;0.662990212440491,0.742156863212585,0.971813738346100;0.650000035762787,0.729411780834198,0.962418317794800;0.637009799480438,0.716666698455811,0.953022897243500;0.624019622802734,0.703921556472778,0.943627476692200;0.611029446125031,0.691176474094391,0.934232056140900;0.598039209842682,0.678431391716003,0.924836635589600;0.585049033164978,0.665686309337616,0.915441155433655;0.572058856487274,0.652941167354584,0.906045734882355;0.559068620204926,0.640196084976196,0.896650314331055;0.546078443527222,0.627451002597809,0.887254893779755;0.533088266849518,0.614705920219421,0.877859473228455;0.520098030567169,0.601960778236389,0.868464052677155;0.507107853889465,0.589215695858002,0.859068632125855;0.494117647409439,0.576470613479614,0.849673211574554;0.481127470731735,0.563725471496582,0.840277791023254;0.468137264251709,0.550980389118195,0.830882370471954;0.455147057771683,0.538235306739807,0.821486949920654;0.442156881093979,0.525490224361420,0.812091529369354;0.429166674613953,0.512745082378388,0.802696108818054;0.416176468133926,0.500000000000000,0.793300688266754;0.403186291456223,0.487254917621613,0.783905267715454;0.390196084976196,0.474509805440903,0.774509787559509;0.377205878496170,0.461764723062515,0.765114367008209;0.364215701818466,0.449019610881805,0.755718946456909;0.351225495338440,0.436274528503418,0.746323525905609;0.338235288858414,0.423529416322708,0.736928105354309;0.325245112180710,0.410784333944321,0.727532684803009;0.312254905700684,0.398039221763611,0.718137264251709;0.299264699220657,0.385294139385223,0.708741843700409;0.286274522542954,0.372549027204514,0.699346423149109;0.273284316062927,0.359803915023804,0.689951002597809;0.260294139385223,0.347058832645416,0.680555582046509;0.247303932905197,0.334313720464706,0.671160161495209;0.234313726425171,0.321568638086319,0.661764740943909;0.221323534846306,0.308823525905609,0.652369320392609;0.208333343267441,0.296078443527222,0.642973899841309;0.195343136787415,0.283333331346512,0.633578479290009;0.182352945208550,0.270588248968124,0.624183058738709;0.169362753629684,0.257843136787415,0.614787578582764;0.156372547149658,0.245098039507866,0.605392158031464;0.143382355570793,0.232352942228317,0.595996737480164;0.130392163991928,0.219607844948769,0.586601316928864;0.117401964962482,0.206862747669220,0.577205896377564;0.104411765933037,0.194117650389671,0.567810475826263;0.0914215743541718,0.181372553110123,0.558415055274963;0.0784313753247261,0.168627455830574,0.549019634723663]
    Rainfall_colourmap2=[1,1,1;0.678431391716003,0.921568632125855,1;0.667488932609558,0.906704604625702,1;0.656546533107758,0.891840636730194,1;0.645604074001312,0.876976609230042,1;0.634661614894867,0.862112581729889,1;0.623719155788422,0.847248554229736,1;0.612776756286621,0.832384586334229,1;0.601834297180176,0.817520558834076,1;0.590891838073731,0.802656531333923,1;0.579949438571930,0.787792563438416,1;0.569006979465485,0.772928535938263,1;0.558064520359039,0.758064508438110,1;0.547122061252594,0.743200480937958,1;0.536179661750794,0.728336513042450,1;0.525237202644348,0.713472485542297,1;0.514294743537903,0.698608458042145,1;0.503352344036102,0.683744490146637,1;0.492409884929657,0.668880462646484,1;0.481467425823212,0.654016435146332,1;0.470524996519089,0.639152467250824,1;0.459582567214966,0.624288439750671,1;0.448640108108521,0.609424412250519,1;0.437697678804398,0.594560384750366,1;0.426755219697952,0.579696416854858,1;0.415812790393829,0.564832389354706,1;0.404870361089706,0.549968361854553,1;0.393927901983261,0.535104393959045,1;0.382985472679138,0.520240366458893,1;0.372043013572693,0.505376338958740,1;0.361100584268570,0.490512341260910,1;0.350158125162125,0.475648313760757,1;0.339215695858002,0.460784316062927,1;0.328273266553879,0.445920318365097,1;0.317330807447433,0.431056290864944,1;0.306388378143311,0.416192293167114,1;0.295445919036865,0.401328265666962,1;0.284503489732742,0.386464267969131,1;0.273561030626297,0.371600240468979,1;0.262618601322174,0.356736242771149,1;0.251676172018051,0.341872245073319,1;0.240733712911606,0.327008217573166,1;0.229791283607483,0.312144219875336,1;0.218848839402199,0.297280192375183,1;0.207906395196915,0.282416194677353,1;0.196963950991631,0.267552196979523,1;0.186021506786346,0.252688169479370,1;0.175079062581062,0.237824156880379,1;0.164136633276939,0.222960159182549,1;0.153194189071655,0.208096146583557,1;0.142251744866371,0.193232133984566,1;0.131309300661087,0.178368121385574,1;0.120366856455803,0.163504108786583,1;0.109424419701099,0.148640096187592,1;0.0984819754958153,0.133776098489761,1;0.0875395312905312,0.118912078440189,1;0.0765970945358276,0.104048073291779,1;0.0656546503305435,0.0891840606927872,1;0.0547122098505497,0.0743200480937958,1;0.0437697656452656,0.0594560392200947,1;0.0328273251652718,0.0445920303463936,1;0.0218848828226328,0.0297280196100473,1;0.0109424414113164,0.0148640098050237,1;0,0,1];
    % Change colourmap as desired (second argument of 'colormap' function)
    colormap(ax,Rainfall_colourmap2);
axis([rl_datsp_hd(2) rl_datsp_hd(4) rl_datsp_hd(5) rl_datsp_hd(1) ]);
axis xy
axis equal       
title(fl_name);
colorbar;
hold on;
S1=shaperead('infuse_uk_2011.shp'); %UK contour
plot([S1.X],[S1.Y],'k');
h1=imagesc(xg,yg,rr_dat_mat,clims);
h2=plot([S1.X],[S1.Y],'k');
saveas(h1,'lalala','jpg')
    saveas(h1,file_to_write,'jpg');
saveas(h2,'lalala','jpg')
--------------------------------
%}    
    
  newName = fullfile(myPath, sprintf( 'radar_rainfall_file%04d.dat', iFile ) );
  movefile( fullfile(myPath, fileNames{ iFile }), newName );
  fprintf('\nRenaming file number %d',iFile);
  fileID = fopen('ListOfRenamedFiles.txt','a');
  % List of renamed files
  fprintf(fileID,formatSpec,fileNames{ iFile },newName);
end
fprintf(fileID,'\n\n');
fclose(fileID);
fprintf('\n');

% Writes ASCII file
files=dir('radar_rainfall*.dat');
C3 = {'ncols',1725;'nrows',2175;'xllcorner',-405000;'yllcorner',-625000;'cellsize',1000;'NODATA_value',-1};
formatSpec = '%s\t%d\n';
[nrows,ncols] = size(C3);
for i=1:length(files)
    file_to_process=sprintf('radar_rainfall_file%04d.dat',i);
    [int_gen_hd,rl_gen_hd,rl_datsp_hd,char_hd,int_datsp_hd,rr_dat_mat,ele_int_gen] = readBADC(file_to_process);
    fprintf('\nNow processing %s\n',file_to_process);
    for j=1:4
        file_to_write=sprintf('RadarRain%04d.asc',i);
        asciifileID = fopen(file_to_write,'w');
            for row = 1:nrows
                fprintf(asciifileID,formatSpec,C3{row,:});
            end
        fprintf(asciifileID,[repmat(' %d ', 1, j) '\n'], rr_dat_mat');
    end
fprintf('Writing %s\n',file_to_write);
fclose(asciifileID);
end
    
% Read rainfall data from *.dat file
function [int_gen_hd,rl_gen_hd,rl_datsp_hd,char_hd,int_datsp_hd,rr_dat_mat,ele_int_gen] = readBADC(fl_name)

ele_int_gen = 33;%The number of elements in 'int_gen_hd'
st_rl_gen = 66;%The byte number where the 'rl_gen_hd' begins, from the beginning of the data file
ele_rl_gen = 28;%The number of elements in 'rl_gen_hd'
st_rl_datsp = 178;%The byte number where the 'rl_datsp_hd' begins, from the beginning of the data file
ele_rl_datsp = 45;%The number of elements in 'rl_datsp_hd'
st_char = 358;%The byte number where the 'char_hd' begins, from the beginning of the data file
ele_char = 56;%The number of characters in 'char_hd'
st_int_datsp = 415;%The byte number where the 'int_datsp_hd' begins, from the beginning of the data file
ele_int_datsp = 53;%The number of elements in 'int_dat_sp'
st_rr_dat = 524;%The byte number where the data matrix begins, from the beginning of the data file
fid = fopen(fl_name,'r');
if fid == -1
    error('File does not exists');
end

int_gen_hd = fread(fid,ele_int_gen,'int16','ieee-be');
data_r = int_gen_hd(18);%The row dimension of the data matrix
data_c = int_gen_hd(19);%The column dimension of the data matrix
fseek(fid,st_rl_gen,'bof');
rl_gen_hd = fread(fid,ele_rl_gen,'float32','ieee-be');
fseek(fid,st_rl_datsp,'bof');
rl_datsp_hd = fread(fid,ele_rl_datsp,'float32','ieee-be');
fseek(fid,st_char,'bof');
char_hd = fread(fid,ele_char,'*char');
fseek(fid,st_int_datsp,'bof');
int_datsp_hd = fread(fid,ele_int_datsp,'int16','ieee-le');
fseek(fid,st_rr_dat,'bof');
rr_dat_mat = fread(fid,[data_c, data_r],'int16','ieee-be');
% data is stored in file row-wise, whereas fread fills array columnwise, so
% transpose array
rr_dat_mat = rr_dat_mat';

fclose(fid);

end


end




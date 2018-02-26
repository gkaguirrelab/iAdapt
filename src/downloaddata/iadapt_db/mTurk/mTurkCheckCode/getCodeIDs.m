function codeIDS = getCodeIDs (mTurkFileName, idIndex, codeIndex)

mTurkFileDir = '../mTurkConfirm/';
mTurkExtension = '.csv';
[header, contents] = read_mixed_csv([mTurkFileDir mTurkFileName mTurkExtension], ',');
codes = contents(:,codeIndex);
ids = contents(:,idIndex);
codes = (strtrim(strrep(codes, '"', '')));
ids = (strtrim(strrep(ids, '"', '')));

codeIDS = [ids codes];



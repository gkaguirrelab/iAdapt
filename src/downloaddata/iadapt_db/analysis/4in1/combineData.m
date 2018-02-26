function combinedData = combineData(data1, data2)
% Assumes data1 has been gathered earlier than data2
combinedData = struct;
idDifference = setdiff(data2.Users.ID, data1.Users.ID);
names = fieldnames(data1);
for i = 1:length(names)
    combinedData.(names{i}) = struct;
    field = data1.(names{i});
    fieldElmts = fieldnames(field);
    idIndexes = [];
     if isfield(field,'ID')
         idIndexes = ismember(data2.(names{i}).('ID'),idDifference);
        else if isfield(field, 'userID')
                idIndexes = ismember(data2.(names{i}).('userID'),idDifference);
            end
     end
    for j = 1:length(fieldElmts)
       if ~isempty(idIndexes)
           if ischar(data2.(names{i}).(fieldElmts{j}))
               data2.(names{i}).(fieldElmts{j}) = cellstr(data2.(names{i}).(fieldElmts{j}));
           end
           if ischar(data1.(names{i}).(fieldElmts{j}))
               data1.(names{i}).(fieldElmts{j}) = cellstr(data1.(names{i}).(fieldElmts{j}));
           end
               combinedData.(names{i}).(fieldElmts{j}) = vertcat(data1.(names{i}).(fieldElmts{j}),data2.(names{i}).(fieldElmts{j})(idIndexes));
       end
    end
end
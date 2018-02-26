function subjectPay = getSubjectPay(codeIDs)

data = loaddb;
codes = cellstr(data.Users.completionCode);
payments = cellstr(data.Users.amountPaid);
userIDs = data.Users.ID;

for i = 1:length(codeIDs)
    index = strcmp(codes,cellstr(strtrim(strrep(codeIDs{i, 2}, '"', ''))));
    payAmount = payments(index);
    if isempty(payAmount)
        payAmount = {''};
    end
    codeIDs(i, 3) = payAmount;
    id = num2cell(userIDs(index));
    if isempty(id)
        id = {NaN};
    end
    codeIDs(i, 4) = id;
end

subjectPay = codeIDs;
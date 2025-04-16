data = readtable("M33176_1_CW_MAIN_AppendixA Osteoporosis Dataset.xlsx");

%change type
data.Menopause= categorical(data.Menopause);
data.Alcohol= categorical(data.Alcohol);
data.Alcohol24= categorical(data.Alcohol24);
data.VitaminD= categorical(data.VitaminD);
data.Calcium= categorical(data.Calcium);

% missing value percent
stats = table();
for feature = 1:width(data)
    if class(data{:, feature}) == "double"
        featData = data{:, feature};
        total = numel(featData);
        count = sum(isnan(featData));
        
        Mean=nanmean(featData);
        Min=nanmin(featData);
        Med= nanmedian(featData);
        Max= nanmax(featData);
        Std= nanstd(featData);
        
    else
        featData = data{:, feature};
        total = numel(featData);
        count = sum(ismissing(featData));
        Mean= "-";
        Min="-";
        Med= "-";
        Max="-";
        Std= "-";
    end
    missingPercentage= ((count / total) * 100);
    stats = [stats; table(string(data.Properties.VariableNames{feature}), missingPercentage,Mean,Min, Med, Max,Std)];
end

% BMI Box plot

boxplot(data.BMI)
title("BMI Distribution")

% Age Histogram

histogram(data.Age,'FaceColor','c')
title("Age Distribution")

% Preprocessing




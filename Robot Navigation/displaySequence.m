%% Create a function which displays the sequence data colored by its
% corresponding label. (X is sensor number, Y is the label)
function displaySequence(X,Y)
    figure
    classNames = categories(Y);
    for i = 1:length(classNames)
        label = classNames(i);
        idx = find(Y == label);
        hold on
        plot(idx,X(idx),'*')
    end
    hold off
    legend(classNames,'Location','northwest')
end
%% end
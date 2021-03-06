    figure;

    if numRuns==1   
        plot(bestobjhist)
        grid on
        grid minor
        Title=['Agent Optimization Over ' num2str(numRuns) ' runs'];
        title(Title)
        xlabel('Learning Cycles')
        ylabel('Performance f(x)')
    else
        medbest=nanmedian(bestobjhist);
        neg=medbest-min(bestobjhist);
        pos=max(bestobjhist)-medbest;
        for r=1:numRuns
            for h=1:length(medbest)
                if ~isnan(bestobjhist(r,h))
                    endptx(r)=h;
                    endpty(r)=bestobjhist(r,h);
                end
                if ~isnan(medbest(h))
                    graphend=h;
                end
            end
        end
        endpt=[endptx;endpty];
        for r=1:numRuns
                numdup{r}=sum(endptx(r)==endptx);
        end
        % Plot line without errorbars. Contains all points.
        plot(1:graphend, medbest(1:graphend), 'k')
        hold on
        L = size(medbest, 2);
        x = [1 10:10:L];
        % Plot errorbar about every 10 points
        % NOTE: Must go into plot editor thing to remove line without removing
        % error bars
        errorbar(x, medbest(x),neg(x),pos(x), 'k')
        %errorbar([1:graphend], medbest(1:graphend),neg(1:graphend),pos(1:graphend))
        Title=['Agent Optimization Over ' num2str(numRuns) ' runs'];
        title(Title)
        xlabel('Learning Cycles')
        ylabel('Performance f(x)')
        xlim([0,graphend])
        ylim([0.25*min(min(bestobjhist)),1.1*max(max(bestobjhist))])
        plot(endptx, endpty, 'o', 'color','r')
        grid on
        grid minor
        figure;
    boxplot(endpty, 'orientation', 'horizontal')
    % axis([900,2300, 0.9, 1.1])
    title('Best values found by each run')
    
    grid on
    grid minor   
    end


hold off 

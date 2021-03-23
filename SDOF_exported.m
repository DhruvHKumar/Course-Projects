classdef SDOF_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                        matlab.ui.Figure
        SingleDegreeOfFreedomCalculatorLabel  matlab.ui.control.Label
        MasskgEditFieldLabel            matlab.ui.control.Label
        MasskgEditField                 matlab.ui.control.NumericEditField
        CalculateButton                 matlab.ui.control.Button
        FreeForcedvibrationButtonGroup  matlab.ui.container.ButtonGroup
        FreeButton_2                    matlab.ui.control.ToggleButton
        ForcedButton                    matlab.ui.control.ToggleButton
        HarmonicinputfrequencyHzEditFieldLabel  matlab.ui.control.Label
        HarmonicinputfrequencyHzEditField  matlab.ui.control.NumericEditField
        StiffnesskNmLabel               matlab.ui.control.Label
        StiffnesskNmEditField           matlab.ui.control.NumericEditField
        DampingratiocoefficientEditFieldLabel  matlab.ui.control.Label
        DampingratiocoefficientEditField  matlab.ui.control.NumericEditField
        NaturalfrequencyEditFieldLabel  matlab.ui.control.Label
        NaturalfrequencyEditField       matlab.ui.control.NumericEditField
        CircularfrequencyEditFieldLabel  matlab.ui.control.Label
        CircularfrequencyEditField      matlab.ui.control.NumericEditField
        PeriodofoscillationEditFieldLabel  matlab.ui.control.Label
        PeriodofoscillationEditField    matlab.ui.control.NumericEditField
        DampednaturalangularfrequencyEditField_2Label  matlab.ui.control.Label
        DampednaturalangularfrequencyEditField_2  matlab.ui.control.NumericEditField
        CriticaldampingEditFieldLabel   matlab.ui.control.Label
        CriticaldampingEditField        matlab.ui.control.NumericEditField
        DampingfactorEditFieldLabel     matlab.ui.control.Label
        DampingfactorEditField          matlab.ui.control.NumericEditField
        DampednaturalfrequencyEditFieldLabel  matlab.ui.control.Label
        DampednaturalfrequencyEditField  matlab.ui.control.NumericEditField
        QualityfactorEditFieldLabel     matlab.ui.control.Label
        QualityfactorEditField          matlab.ui.control.NumericEditField
        TransmissibilityEditFieldLabel  matlab.ui.control.Label
        TransmissibilityEditField       matlab.ui.control.NumericEditField
        ResultsLabel                    matlab.ui.control.Label
        InputLabel                      matlab.ui.control.Label
        AppbyDhruvHKumar181ME220Label   matlab.ui.control.Label
        UIAxes                          matlab.ui.control.UIAxes
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: CalculateButton
        function CalculateButtonPushed(app, event)
           
            m=app.MasskgEditField.Value;
            k=app.StiffnesskNmEditField.Value;
            zeta=app.DampingratiocoefficientEditField.Value;
            omega=app.HarmonicinputfrequencyHzEditField.Value;
            
            %%Value of pi
            p=pi;
           
            %%Natural Circular frequency
            wn=sqrt(k/m);
            
            %%Natural Circular frequency
            fn=wn /(2 * p) ;
            
            %%Time period
            t=1/fn;
            
            %%Critcial Damping 
            cc=2*m*wn;
            
            %%Damping Factor
            c=zeta*cc;
            
            %%Damped Natural angular Frequency
            wd= wn * ( sqrt(1-(zeta * zeta)) );
            
            %%Damped Natural Frequency
            fd=wd /(2 * p) ;
            
            %%Quality factor
            Q=1/(2 * zeta);
              
            x= 0.1: 0.01:3;

                    for i = 1:291
                        y(i) = (sqrt((1 + (2*zeta*x(i))^2)/((1-x(i)^2)^2 + (2*zeta*x(i))^2)));
                    end
                
            
            
            %%Transmissibility
            
            a=(omega/fn)^2;
                b= (1 + 4*zeta^2*a) ;
                d= (1 - a)^2;
                j= 4*zeta^2*a;
                TR=sqrt(b/(d + j));
             
             %% Plotting the graph
              loglog(app.UIAxes,y);
                
             app.CircularfrequencyEditField.Value=wn;
             app.NaturalfrequencyEditField.Value=fn;
             app.PeriodofoscillationEditField.Value=t;
             app.CriticaldampingEditField.Value=cc;
             app.DampingfactorEditField.Value=c;
             app.DampednaturalangularfrequencyEditField_2.Value=wd;
             app.DampednaturalfrequencyEditField.Value=fd;
             app.QualityfactorEditField.Value=Q;
             app.TransmissibilityEditField.Value=TR;
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 687 618];
            app.UIFigure.Name = 'MATLAB App';

            % Create SingleDegreeOfFreedomCalculatorLabel
            app.SingleDegreeOfFreedomCalculatorLabel = uilabel(app.UIFigure);
            app.SingleDegreeOfFreedomCalculatorLabel.FontName = 'TakaoMincho';
            app.SingleDegreeOfFreedomCalculatorLabel.FontSize = 24;
            app.SingleDegreeOfFreedomCalculatorLabel.FontWeight = 'bold';
            app.SingleDegreeOfFreedomCalculatorLabel.Position = [136 549 434 54];
            app.SingleDegreeOfFreedomCalculatorLabel.Text = 'Single Degree Of Freedom Calculator';

            % Create MasskgEditFieldLabel
            app.MasskgEditFieldLabel = uilabel(app.UIFigure);
            app.MasskgEditFieldLabel.HorizontalAlignment = 'right';
            app.MasskgEditFieldLabel.FontSize = 10;
            app.MasskgEditFieldLabel.Position = [56 462 47 23];
            app.MasskgEditFieldLabel.Text = 'Mass(kg)';

            % Create MasskgEditField
            app.MasskgEditField = uieditfield(app.UIFigure, 'numeric');
            app.MasskgEditField.Position = [166 463 103 20];

            % Create CalculateButton
            app.CalculateButton = uibutton(app.UIFigure, 'push');
            app.CalculateButton.ButtonPushedFcn = createCallbackFcn(app, @CalculateButtonPushed, true);
            app.CalculateButton.BackgroundColor = [0.9294 0.6941 0.1255];
            app.CalculateButton.FontSize = 24;
            app.CalculateButton.FontColor = [1 1 1];
            app.CalculateButton.Position = [79 142 145 64];
            app.CalculateButton.Text = 'Calculate';

            % Create FreeForcedvibrationButtonGroup
            app.FreeForcedvibrationButtonGroup = uibuttongroup(app.UIFigure);
            app.FreeForcedvibrationButtonGroup.Title = 'Free-Forced vibration';
            app.FreeForcedvibrationButtonGroup.FontSize = 10;
            app.FreeForcedvibrationButtonGroup.Position = [49 321 232 62];

            % Create FreeButton_2
            app.FreeButton_2 = uitogglebutton(app.FreeForcedvibrationButtonGroup);
            app.FreeButton_2.Text = 'Free';
            app.FreeButton_2.FontSize = 10;
            app.FreeButton_2.Position = [12 12 100 22];
            app.FreeButton_2.Value = true;

            % Create ForcedButton
            app.ForcedButton = uitogglebutton(app.FreeForcedvibrationButtonGroup);
            app.ForcedButton.Text = 'Forced';
            app.ForcedButton.FontSize = 10;
            app.ForcedButton.Position = [120 12 100 22];

            % Create HarmonicinputfrequencyHzEditFieldLabel
            app.HarmonicinputfrequencyHzEditFieldLabel = uilabel(app.UIFigure);
            app.HarmonicinputfrequencyHzEditFieldLabel.FontSize = 10;
            app.HarmonicinputfrequencyHzEditFieldLabel.Position = [28 280 165 22];
            app.HarmonicinputfrequencyHzEditFieldLabel.Text = 'Harmonic input frequency(Hz)';

            % Create HarmonicinputfrequencyHzEditField
            app.HarmonicinputfrequencyHzEditField = uieditfield(app.UIFigure, 'numeric');
            app.HarmonicinputfrequencyHzEditField.Position = [167 279 104 24];

            % Create StiffnesskNmLabel
            app.StiffnesskNmLabel = uilabel(app.UIFigure);
            app.StiffnesskNmLabel.HorizontalAlignment = 'center';
            app.StiffnesskNmLabel.FontSize = 10;
            app.StiffnesskNmLabel.Position = [35 431 82 23];
            app.StiffnesskNmLabel.Text = 'Stiffness- k (N/m)';

            % Create StiffnesskNmEditField
            app.StiffnesskNmEditField = uieditfield(app.UIFigure, 'numeric');
            app.StiffnesskNmEditField.Position = [166 432 103 20];

            % Create DampingratiocoefficientEditFieldLabel
            app.DampingratiocoefficientEditFieldLabel = uilabel(app.UIFigure);
            app.DampingratiocoefficientEditFieldLabel.HorizontalAlignment = 'center';
            app.DampingratiocoefficientEditFieldLabel.FontSize = 10;
            app.DampingratiocoefficientEditFieldLabel.Position = [19 393 119 23];
            app.DampingratiocoefficientEditFieldLabel.Text = 'Damping ratio(coefficient)';

            % Create DampingratiocoefficientEditField
            app.DampingratiocoefficientEditField = uieditfield(app.UIFigure, 'numeric');
            app.DampingratiocoefficientEditField.Position = [168 394 103 20];

            % Create NaturalfrequencyEditFieldLabel
            app.NaturalfrequencyEditFieldLabel = uilabel(app.UIFigure);
            app.NaturalfrequencyEditFieldLabel.HorizontalAlignment = 'center';
            app.NaturalfrequencyEditFieldLabel.FontSize = 10;
            app.NaturalfrequencyEditFieldLabel.Position = [388 458 84 23];
            app.NaturalfrequencyEditFieldLabel.Text = 'Natural frequency';

            % Create NaturalfrequencyEditField
            app.NaturalfrequencyEditField = uieditfield(app.UIFigure, 'numeric');
            app.NaturalfrequencyEditField.Position = [520 459 103 20];

            % Create CircularfrequencyEditFieldLabel
            app.CircularfrequencyEditFieldLabel = uilabel(app.UIFigure);
            app.CircularfrequencyEditFieldLabel.HorizontalAlignment = 'center';
            app.CircularfrequencyEditFieldLabel.FontSize = 10;
            app.CircularfrequencyEditFieldLabel.Position = [386 485 86 23];
            app.CircularfrequencyEditFieldLabel.Text = 'Circular frequency';

            % Create CircularfrequencyEditField
            app.CircularfrequencyEditField = uieditfield(app.UIFigure, 'numeric');
            app.CircularfrequencyEditField.Position = [519 486 103 20];

            % Create PeriodofoscillationEditFieldLabel
            app.PeriodofoscillationEditFieldLabel = uilabel(app.UIFigure);
            app.PeriodofoscillationEditFieldLabel.HorizontalAlignment = 'center';
            app.PeriodofoscillationEditFieldLabel.FontSize = 10;
            app.PeriodofoscillationEditFieldLabel.Position = [383 431 92 23];
            app.PeriodofoscillationEditFieldLabel.Text = 'Period of oscillation';

            % Create PeriodofoscillationEditField
            app.PeriodofoscillationEditField = uieditfield(app.UIFigure, 'numeric');
            app.PeriodofoscillationEditField.Position = [518 432 103 20];

            % Create DampednaturalangularfrequencyEditField_2Label
            app.DampednaturalangularfrequencyEditField_2Label = uilabel(app.UIFigure);
            app.DampednaturalangularfrequencyEditField_2Label.HorizontalAlignment = 'center';
            app.DampednaturalangularfrequencyEditField_2Label.FontSize = 10;
            app.DampednaturalangularfrequencyEditField_2Label.Position = [349 339 159 23];
            app.DampednaturalangularfrequencyEditField_2Label.Text = 'Damped natural angular frequency';

            % Create DampednaturalangularfrequencyEditField_2
            app.DampednaturalangularfrequencyEditField_2 = uieditfield(app.UIFigure, 'numeric');
            app.DampednaturalangularfrequencyEditField_2.Position = [518 340 103 20];

            % Create CriticaldampingEditFieldLabel
            app.CriticaldampingEditFieldLabel = uilabel(app.UIFigure);
            app.CriticaldampingEditFieldLabel.HorizontalAlignment = 'center';
            app.CriticaldampingEditFieldLabel.FontSize = 10;
            app.CriticaldampingEditFieldLabel.Position = [383 399 92 23];
            app.CriticaldampingEditFieldLabel.Text = 'Critical damping';

            % Create CriticaldampingEditField
            app.CriticaldampingEditField = uieditfield(app.UIFigure, 'numeric');
            app.CriticaldampingEditField.Position = [518 400 103 20];

            % Create DampingfactorEditFieldLabel
            app.DampingfactorEditFieldLabel = uilabel(app.UIFigure);
            app.DampingfactorEditFieldLabel.HorizontalAlignment = 'center';
            app.DampingfactorEditFieldLabel.FontSize = 10;
            app.DampingfactorEditFieldLabel.Position = [383 371 92 23];
            app.DampingfactorEditFieldLabel.Text = 'Damping factor';

            % Create DampingfactorEditField
            app.DampingfactorEditField = uieditfield(app.UIFigure, 'numeric');
            app.DampingfactorEditField.Position = [518 372 103 20];

            % Create DampednaturalfrequencyEditFieldLabel
            app.DampednaturalfrequencyEditFieldLabel = uilabel(app.UIFigure);
            app.DampednaturalfrequencyEditFieldLabel.HorizontalAlignment = 'center';
            app.DampednaturalfrequencyEditFieldLabel.FontSize = 10;
            app.DampednaturalfrequencyEditFieldLabel.Position = [349 307 159 23];
            app.DampednaturalfrequencyEditFieldLabel.Text = 'Damped natural frequency';

            % Create DampednaturalfrequencyEditField
            app.DampednaturalfrequencyEditField = uieditfield(app.UIFigure, 'numeric');
            app.DampednaturalfrequencyEditField.Position = [518 308 103 20];

            % Create QualityfactorEditFieldLabel
            app.QualityfactorEditFieldLabel = uilabel(app.UIFigure);
            app.QualityfactorEditFieldLabel.HorizontalAlignment = 'center';
            app.QualityfactorEditFieldLabel.FontSize = 10;
            app.QualityfactorEditFieldLabel.Position = [349 276 159 23];
            app.QualityfactorEditFieldLabel.Text = 'Quality factor';

            % Create QualityfactorEditField
            app.QualityfactorEditField = uieditfield(app.UIFigure, 'numeric');
            app.QualityfactorEditField.Position = [518 277 103 20];

            % Create TransmissibilityEditFieldLabel
            app.TransmissibilityEditFieldLabel = uilabel(app.UIFigure);
            app.TransmissibilityEditFieldLabel.HorizontalAlignment = 'center';
            app.TransmissibilityEditFieldLabel.FontSize = 10;
            app.TransmissibilityEditFieldLabel.Position = [349 243 159 23];
            app.TransmissibilityEditFieldLabel.Text = 'Transmissibility';

            % Create TransmissibilityEditField
            app.TransmissibilityEditField = uieditfield(app.UIFigure, 'numeric');
            app.TransmissibilityEditField.Position = [518 244 103 20];

            % Create ResultsLabel
            app.ResultsLabel = uilabel(app.UIFigure);
            app.ResultsLabel.HorizontalAlignment = 'center';
            app.ResultsLabel.FontName = 'DejaVu Serif';
            app.ResultsLabel.FontSize = 16;
            app.ResultsLabel.FontWeight = 'bold';
            app.ResultsLabel.Position = [439 517 131 22];
            app.ResultsLabel.Text = 'Results';

            % Create InputLabel
            app.InputLabel = uilabel(app.UIFigure);
            app.InputLabel.HorizontalAlignment = 'center';
            app.InputLabel.FontName = 'DejaVu Serif';
            app.InputLabel.FontSize = 16;
            app.InputLabel.FontWeight = 'bold';
            app.InputLabel.Position = [111 507 131 22];
            app.InputLabel.Text = 'Input';

            % Create AppbyDhruvHKumar181ME220Label
            app.AppbyDhruvHKumar181ME220Label = uilabel(app.UIFigure);
            app.AppbyDhruvHKumar181ME220Label.Position = [56 50 150 62];
            app.AppbyDhruvHKumar181ME220Label.Text = {'App by:'; ''; 'Dhruv H Kumar'; '181ME220'};

            % Create UIAxes
            app.UIAxes = uiaxes(app.UIFigure);
            title(app.UIAxes, {'Transmissibility vs Frequency graph'; ''})
            xlabel(app.UIAxes, 'Frequency Ratio')
            ylabel(app.UIAxes, 'Transmissibilty')
            zlabel(app.UIAxes, 'Z')
            app.UIAxes.XGrid = 'on';
            app.UIAxes.YGrid = 'on';
            app.UIAxes.Position = [322 16 324 213];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = SDOF_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end
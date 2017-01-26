function rewards=switch_diff(ag,G, penalty,scaleFactor, battery, motor, prop, foil, rod,sys,res, data)

% Create "average" components (moved this from main)
        [avgCell, avgMotor, avgProp, avgFoil, avgRod] = counter_calc(data.batteryData, ...
            data.motorData, data.propData, data.foilData, data.rodData, data.matData);
        motorNum=motor.Num; 
        
            switch ag
                case 1 % want to replace cell with avgCell
                    counterBattery = create_battery(avgCell, battery.sConfigs, battery.pConfigs);
                    counterSys=design_sys(counterBattery, motor, prop, foil, rod, res, motorNum);
                    rewards = G - calc_G(penalty,scaleFactor, counterBattery, motor, prop, foil, rod, counterSys);
                case 2 % replace sConfigs with 2
                    counterBattery = create_battery(battery.cell, 2, battery.pConfigs);
                    counterSys=design_sys(counterBattery, motor, prop, foil, rod, res, motorNum);
                    rewards = G - calc_G(penalty,scaleFactor, counterBattery, motor, prop, foil, rod, counterSys);
                case 3 % replace pConfigs with 1
                    counterBattery = create_battery(battery.cell, battery.sConfigs, 1);
                    counterSys=design_sys(counterBattery, motor, prop, foil, rod, res, motorNum);
                    rewards = G - calc_G(penalty,scaleFactor, counterBattery, motor, prop, foil, rod, counterSys);
                case 4 % replace motor with its average counterpart
                    counterSys=design_sys(battery, avgMotor, prop, foil, rod, res, 0);
                    rewards = G - calc_G(penalty,scaleFactor, battery, avgMotor, prop, foil, rod, counterSys);
                case 5 % replace foil with its average counterpart
                    counterProp = create_prop(prop.diameter, prop.angleRoot, ...
                        prop.angleTip, prop.chordRoot, prop.chordTip,avgFoil);
                    counterSys=design_sys(battery, motor, counterProp, avgFoil, rod, res, motorNum);
                    rewards = G - calc_G(penalty,scaleFactor, battery, motor, prop, avgFoil, rod, counterSys);
                case 6
                    counterProp = create_prop(avgProp.diameter, prop.angleRoot, ...
                        prop.angleTip, prop.chordRoot, prop.chordTip,foil);
                    counterSys=design_sys(battery, motor, counterProp, foil, rod, res, motorNum);
                    rewards = G - calc_G(penalty,scaleFactor, battery, motor, counterProp, foil, rod, counterSys);
                case 7
                    counterProp = create_prop(prop.diameter, avgProp.angleRoot, ...
                        prop.angleTip, prop.chordRoot, prop.chordTip,foil);
                    counterSys=design_sys(battery, motor, counterProp, foil, rod, res, motorNum);
                    rewards = G - calc_G(penalty,scaleFactor, battery, motor, counterProp, foil, rod, counterSys);
                case 8
                    counterProp = create_prop(prop.diameter, avgProp.angleRoot, ...
                        avgProp.angleTip, prop.chordRoot, prop.chordTip,foil);
                    counterSys=design_sys(battery, motor, counterProp, foil, rod, res, motorNum);
                    rewards = G - calc_G(penalty,scaleFactor, battery, motor, counterProp, foil, rod, counterSys);
                case 9
                    counterProp = create_prop(prop.diameter, prop.angleRoot, ...
                        prop.angleTip, avgProp.chordRoot, prop.chordTip,foil);
                    counterSys=design_sys(battery, motor, counterProp, foil, rod, res, motorNum);
                    rewards = G - calc_G(penalty,scaleFactor, battery, motor, counterProp, foil, rod, counterSys);
                case 10
                    counterProp = create_prop(prop.diameter, prop.angleRoot, ...
                        prop.angleTip, prop.chordRoot, avgProp.chordTip,foil);
                    counterSys=design_sys(battery, motor, counterProp, foil, rod, res, motorNum);
                    rewards = G - calc_G(penalty,scaleFactor, battery, motor, counterProp, foil, rod, counterSys);
                case 11 % material
                    % Counterfact rod's material replaced with avg material
                    counterRod = create_rod(avgRod.mat, rod.Length, rod.Dia, rod.Thick);
                    counterSys=design_sys(battery, motor, prop, foil, counterRod, res, motorNum);
                    rewards = G - calc_G(penalty,scaleFactor, battery, motor, prop, foil, counterRod, counterSys);
                %case 12 % Rod length
                %    % Counterfact rod's length is replaced with avg rod length
                %    counterRod = create_rod(rod.mat, avgRod.Length, rod.Dia, rod.Thick);
                %    rewards(ag, 1) = G - calc_G(penalty,scaleFactor, battery, motor, prop, foil, counterRod);
                case 12
                    % Counterfact rod's dia replaced with avg rod's dia
                    counterRod = create_rod(rod.mat, rod.Length, avgRod.Dia, rod.Thick);
                    counterSys=design_sys(battery, motor, prop, foil, counterRod, res, motorNum);
                    rewards = G - calc_G(penalty,scaleFactor, battery, motor, prop, foil, counterRod, counterSys);
                case 13
                    % thickness replaced by avg rod's thickness
                    counterRod = create_rod(rod.mat, rod.Length, rod.Dia, avgRod.Thick);
                    counterSys=design_sys(battery, motor, prop, foil, counterRod, res, motorNum);
                    rewards = G - calc_G(penalty,scaleFactor, battery, motor, prop, foil, counterRod, counterSys);
            end
    end
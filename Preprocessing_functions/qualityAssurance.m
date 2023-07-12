disp("Select the LIFE folder you wish to perform quality assurance for")
life_folder = uigetdir("*", "Choose a LIFE folder");
cd(life_folder)
lifeDir = dir(life_folder);

disp("Unzipping dicoms...")
dcm_folder = fullfile(life_folder, 'dicoms');
unzipDicoms(dcm_folder)

disp('~~~~~~~~~~~~~~~~~~~ Ascending Aorta (Cartesian) ~~~~~~~~~~~~~~~~~~~')
disp("Loading...")
[cart_asc_exist, cart_asc] = checkExistence(dcm_folder, '*PWV_CartBH_AAo');
if cart_asc_exist == 1
    copyfile(fullfile(dcm_folder, cart_asc), fullfile(life_folder, cart_asc))
    cart_asc_data = loadCartesian2DPC(fullfile(life_folder, cart_asc));
    g = figure; imshow3D(cart_asc_data.vz)
    movegui(g, "east")
    h = figure; imshow3D(cart_asc_data.mag)
    movegui(h, "west")
    disp("Press enter in command window when ready to move on")
    pause
    close all
    cd(life_folder)
end


disp('~~~~~~~~~~~~~~~~~~~ Abdominal Aorta (Cartesian) ~~~~~~~~~~~~~~~~~~~')
disp("Loading...")
[cart_abd_exist, cart_abd] = checkExistence(dcm_folder, '*PWV_CartBH_AbdAo');
if cart_abd_exist == 1
    copyfile(fullfile(dcm_folder, cart_abd), fullfile(life_folder, cart_abd))
    cart_abd_data = loadCartesian2DPC(fullfile(life_folder, cart_abd));
    g = figure; imshow3D(cart_abd_data.vz)
    movegui(g, "east")
    h = figure; imshow3D(cart_abd_data.mag)
    movegui(h, "west")
    disp("Press enter in command window when ready to move on")
    pause
    close all
    cd(life_folder)
end

disp('~~~~~~~~~~~~~~~~~~~ Ascending Aorta (Radial) ~~~~~~~~~~~~~~~~~~~')
[rad_asc_exist, rad_asc] = checkExistence(life_folder, '*radial_AAo');
if rad_asc_exist == 1
    cd(rad_asc)
    disp("Checking gating data")
    disp("Select raw_data folder. Return to this window once done")
    importGating;
    disp("Press enter in command window when ready to move on")
    pause
    close all
    [standard_asc_exist, standard_asc] = checkExistence(fullfile(life_folder, rad_asc), '*standard*');
    if standard_asc_exist
        rad_asc_data = loadRadial2DPC(fullfile(life_folder, rad_asc, standard_asc, 'dat'));
%         g = figure; imshow3D(rad_asc_data.vz)
%         movegui(g, "north")
        h = figure; imshow3D(rad_asc_data.mag)
        movegui(h, "west")
        disp("Press enter in command window when ready to move on")
        pause
        close all
    end
    cd(life_folder)
end

disp('~~~~~~~~~~~~~~~~~~~ Abdominal Aorta (Radial) ~~~~~~~~~~~~~~~~~~~')
[rad_abd_exist, rad_abd] = checkExistence(life_folder, '*radial_AbdAo');
if rad_abd_exist == 1
    cd(rad_abd)
    disp("Checking gating data")
    disp("Select raw_data folder. Return to this window once done")
    importGating;
    disp("Press enter in command window when ready to move on")
    pause
    close all
    [standard_abd_exist, standard_abd] = checkExistence(fullfile(life_folder, rad_abd), '*standard*');
    if standard_abd_exist
        rad_abd_data = loadRadial2DPC(fullfile(life_folder, rad_abd, standard_abd, 'dat'));
%         g = figure; imshow3D(rad_abd_data.vz)
%         movegui(g, "north")
        h = figure; imshow3D(rad_abd_data.mag)
        movegui(h, "west")
        disp("Press enter in command window when ready to move on")
        pause
        close all
    end
    cd(life_folder)
end
close all; clear;
disp("Quality assurance complete!")
disp("(•_•)    ( •_•)>⌐■-■     (⌐■_■)")

function [value, name] = checkExistence(folder, search_pattern)
    check = dir([folder,'\',search_pattern]);
    if isempty(check)
        disp('No folders found')
        value = 0;
        name = [];
    elseif length(check) > 1
        disp('Multiple folders found. Please choose one and rename the rest')
        value = 2;
        name = [check.name];
    else
        value = 1;
        name = [check.name];
    end
end
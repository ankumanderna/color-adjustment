function rotationGUI2()
    %# setup GUI
    hFig = figure('menu','none', 'Position',[100 100 750 420]);
    hAx = axes('Parent',hFig, 'Units','pixels', 'Position',[50 70 350 300]);
    hAx1 = axes('Parent',hFig, 'Units','pixels', 'Position',[450 230 250 140]);
    hAx2 = axes('Parent',hFig, 'Units','pixels', 'Position',[450 70 250 140]);
%     uicontrol('Parent',hFig, 'Style','slider', 'Value',0, 'Min',0,...
%         'Max',360, 'SliderStep',[1 10]./360, ...
%         'Position',[100 20 300 30], 'Callback',@slider_callback) 
    hTxt = uicontrol('Style','text', 'String','0', ...
        'Units','pixels', 'Position',[240 25 20 15]);

    %# read and show image
    I = imread('cameraman.tif');
    hImg = imshow(I, 'Parent',hAx);
    set(hImg, 'ButtonDownFcn',@image_ButtonDownFcn);  %# attach event listener

%     %# Callback functions
%     function slider_callback(hObj, eventdata)
%         angle = round( get(hObj,'Value') );             %# rotation angle
%         I_rot = imrotate(I, angle, 'bilinear', 'crop'); %# rotate image
%         set(hImg, 'CData',I_rot)                        %# update image
%         set(hTxt, 'String',num2str(angle))              %# update text
%     end
    function image_ButtonDownFcn(hObj,eventdata)
        hRect = imrect(hAx);
        setColor(hRect, 'black');
        rectPos = wait(hRect);
        delete(hRect)

        I1 = imcrop(I, rectPos);                  %# crop from original image
        I2 = imcrop(get(hImg,'CData'), rectPos);  %# crop from rotated image
        imshow(I1, 'Parent',hAx1)
        imshow(I2, 'Parent',hAx2)
    end
end
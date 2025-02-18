%% Band definitions
freqs = 0.78:0.39:19.14;
delta = find(freqs >= 0 & freqs <= 4);      % delta 0 - 4 Hz
theta = find(freqs >= 4 & freqs <= 8);      % theta 4 - 8 Hz
alpha = find(freqs >= 8 & freqs <= 12.5);   % alpha 8 - 12.5 Hz
beta  = find(freqs >= 12.5 & freqs <= 20);  % beta 12.5 - 20 Hz
bands{1} = delta;
bands{2} = theta;
bands{3} = alpha;
bands{4} = beta;
%% Figure stats
for met = 1:length(metric_list)
    mtname = metric_list{met};
    mtname = strcat(mtname,'_interp');
    metric_interp = tstatps.(mtname);
    fig = figure;
    for band = 1:length(bands)
        metric_tmpe = metric_interp(:,bands{band});
        metric_tmpe = metric_tmpe';
        metric_tmpe = max(metric_tmpe.*(metric_tmpe > 0)) + min(metric_tmpe.*(metric_tmpe < 0));
        metric_tmpe = metric_tmpe';
        plot_tmpe = subplot(1,4,band);
        ptch_tmpe = patch( 'Faces',Faces, ...
            'Vertices',         Vertices,...
            'VertexNormals',    VertNormals, ...
            'VertexNormalsMode', 'auto',...
            'FaceNormals',      [],...
            'FaceNormalsMode',  'auto',...
            'FaceVertexCData',  metric_tmpe, ...
            'FaceColor',        'inter', ...
            'FaceAlpha',        1, ...
            'AlphaDataMapping', 'none', ...
            'EdgeColor',        'none', ...
            'EdgeAlpha',        1, ...
            'LineWidth',         0.5,...
            'LineJoin',         'miter',...
            'AmbientStrength',  0.5, ...
            'DiffuseStrength',  0.5, ...
            'SpecularStrength', 0.2, ...
            'SpecularExponent', 1, ...
            'SpecularColorReflectance', 0.5, ...
            'FaceLighting',     'gouraud', ...
            'EdgeLighting',     'gouraud', ...
            'Tag',              'AnatSurface');
        axis off;
        rotate3d on;
        axis tight;
        view(90,90)
        ax = gca;
        max_val = max(abs(metric_tmpe));
        ax.CLim = [(-max_val-0.01) (max_val+0.01)];
        colormap(bipolar(201, 0.3))
        copyobj(ptch_tmpe,plot_tmpe);
    end
    saveas(fig,strcat(mtname,'_band.fig'));
    close(fig)
end
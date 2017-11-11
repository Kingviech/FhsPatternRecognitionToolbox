function plotDensities(data)

square_size_data= sqrt(length(data.x));

figure;
transparency= 1;
re_dens1=reshape(data.parzen_dens(:,1), square_size_data, square_size_data);
X= reshape(data.x(:,1), square_size_data, square_size_data);
Y= reshape(data.x(:,2), square_size_data, square_size_data);

a= surf(X, Y, re_dens1);
set(a,'FaceColor',[1 0 0],'FaceAlpha',transparency);
hold on;

re_dens2=reshape(data.parzen_dens(:,2), square_size_data, square_size_data);
a=surf(X,Y, re_dens2);
set(a,'FaceColor',[0 0 1],'FaceAlpha',transparency);
title('Parzen Windows Density Estimation');

figure;
transparency= 1;
re_dens1=reshape(data.bayes_dens(:,1),square_size_data, square_size_data);
a= surf(X,Y, re_dens1);
set(a,'FaceColor',[1 0 0],'FaceAlpha',transparency);
hold on;

re_dens2=reshape(data.bayes_dens(:,2), square_size_data, square_size_data);
a=surf(X,Y, re_dens2);
set(a,'FaceColor',[0 0 1],'FaceAlpha',transparency);
title('Bayes Posteriori Probability Density Estimation');

end






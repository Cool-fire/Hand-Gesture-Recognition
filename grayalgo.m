function OUT = grayalgo(I)

    [m,n,~] = size(I);
    Rmean = sum(sum(I(:,:,1)))/(m*n);
    Gmean = sum(sum(I(:,:,2)))/(m*n);
    Bmean = sum(sum(I(:,:,3)))/(m*n);
    
    avg = mean([Rmean Gmean Bmean]);
    kr = avg /Rmean;
    kg = avg /Gmean;
    kb = avg /Bmean;
    OUT(:,:,1) = kr*double(I(:,:,1));
    OUT(:,:,2) = kg*double(I(:,:,2));
    OUT(:,:,3) = kb*double(I(:,:,3));
    OUT = uint8(OUT);
end
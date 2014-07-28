function [ output_args ] = firstDeriv(z)
index = []; 
value = []; 
for i=1:length(z)
    index = [index, i(1)];
    value = [index, i(2)]; 
end 

interp_z = interp1(1:length(z), index, value); 
h = fspecial('gaussian', [3,3], 3); 
interp_smooth_z = imfilter(interp_z, h); 
deriv_z = diff(interp_smooth_z,1,2);

deriv_index = []; 
for i=1:length(deriv_z)
    first = deriv_z(val)
    try 
        second = deriv_z(val+1)
    catch err 
    end 
    if (first > 0 && second < 0) || (first < 0 && second > 0)
        if deriv_z(val) > deriv_z(val+1)
            deriv_index = [deriv_index, val+1]; 
        elseif deriv_z[val] < deriv_z(val+1)
            deriv_index = [deriv_index, val]; 
        end 
    end 
            
end

plotting = []; 
for i=1:length(deriv_index)
    plotting = [plotting, 
    


end


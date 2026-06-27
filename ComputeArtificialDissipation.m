function D = ComputeArtificialDissipation(mesh,W)

%% ============================================================
% COMPUTEARTIFICIALDISSIPATION
%
% Simple JST second-order artificial dissipation
%
% D = eps2*(d2W/dx2 + d2W/dr2)
%
%% ============================================================

eps2 = 1.0;

nxc = mesh.nxc;
nrc = mesh.nrc;

D = zeros(nxc,nrc,4);

for k = 1:4

    for i = 2:nxc-1

        for j = 2:nrc-1

            d2x = ...
                W(i+1,j,k) ...
              - 2*W(i,j,k) ...
              + W(i-1,j,k);

            d2r = ...
                W(i,j+1,k) ...
              - 2*W(i,j,k) ...
              + W(i,j-1,k);
                
            dr_local = 0.5*(mesh.dr(i,j) + mesh.dr(i+1,j));
            
            D(i,j,k)=eps2*( d2x/mesh.dx^2 + d2r/(dr_local^2) );

        end

    end

end

end
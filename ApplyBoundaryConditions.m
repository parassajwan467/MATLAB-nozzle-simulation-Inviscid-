function W = ApplyBoundaryConditions(mesh,W)

%% ============================================================
% APPLYBOUNDARYCONDITIONS
%
% Boundary conditions for axisymmetric inviscid nozzle flow
%
% Inlet  : zero-gradient
% Exit   : supersonic outflow
% Axis   : symmetry
% Wall   : slip wall
%
%% ============================================================

%% ------------------------------------------------------------
% Dimensions
%% ------------------------------------------------------------

nxc = mesh.nxc;
nrc = mesh.nrc;

%% ============================================================
% INLET
%
% Zero-gradient extrapolation
%% ============================================================

W(1,:,:) = W(2,:,:);

%% ============================================================
% EXIT
%
% Supersonic outflow
%
% Zero-gradient extrapolation
%% ============================================================

W(nxc,:,:) = W(nxc-1,:,:);

%% ============================================================
% AXIS OF SYMMETRY
%
% r = 0
%
% v = 0
%
%% ============================================================

for i = 1:nxc

    rho  = W(i,2,1);

    rhou = W(i,2,2);

    rhoE = W(i,2,4);

    W(i,1,1) = rho;

    W(i,1,2) = rhou;

    W(i,1,3) = 0.0;

    W(i,1,4) = rhoE;

end

%% ============================================================
% WALL
%
% Slip wall:
%
% Velocity normal to wall = 0
%
%% ============================================================

for i = 1:nxc

    j = nrc;

    rho  = W(i,j-1,1);

    rhou = W(i,j-1,2);

    rhov = W(i,j-1,3);

    rhoE = W(i,j-1,4);

    u = rhou/rho;

    v = rhov/rho;

    nx = mesh.SN_x(i,j);
    nr = mesh.SN_r(i,j);

    mag = mesh.LN(i,j);

    if mag < 1e-12
        error('Invalid wall face length at i=%d, j=%d',i,j);
    end

    nx = nx/mag;
    nr = nr/mag;

    Vn = u*nx + v*nr;

    uWall = u - Vn*nx;
    vWall = v - Vn*nr;

    W(i,j,1) = rho;

    W(i,j,2) = rho*uWall;

    W(i,j,3) = rho*vWall;

    W(i,j,4) = rhoE;

end

end
function Residual = BuildResidual(mesh,W)

%% ============================================================
% BUILDRESIDUAL
%
% Builds the complete finite-volume residual:
%
% Residual =
%   Flux Residual
% + Source Term
% + Artificial Dissipation
%
%% ============================================================

%% ------------------------------------------------------------
% Conservative -> Primitive
%% ------------------------------------------------------------

prim = PrimitiveFromW(W);

%% ------------------------------------------------------------
% Inviscid Fluxes
%% ------------------------------------------------------------

[F,G] = ComputeFluxes(mesh,prim);

%% ------------------------------------------------------------
% Axisymmetric Source Term
%%
%% H =
%%
%% [ 0 ]
%% [ 0 ]
%% [ p ]
%% [ 0 ]
%%
%% ------------------------------------------------------------

H = zeros(mesh.nxc,mesh.nrc,4);

H(:,:,3) = prim.p;

%% ------------------------------------------------------------
% Artificial Dissipation
%% ------------------------------------------------------------

D = ComputeArtificialDissipation(mesh,W);

%% ------------------------------------------------------------
% Residual Assembly
%% ------------------------------------------------------------

Residual = ComputeResidual(mesh, F, G, H, D);

end
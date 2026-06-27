function dt = ComputeTimeStep(mesh,prim,CFL)

%% ============================================================
% COMPUTETIMESTEP
%
% Computes global timestep using CFL condition
%
% dt = CFL * min(dx/(|u|+a), dr/(|v|+a))
%
%% ============================================================

dt = 1e20;

for i = 1:mesh.nxc

    for j = 1:mesh.nrc

        dx_local = mesh.dx;

        dr_local = 0.5*( ...
            mesh.dr(i,j) + ...
            mesh.dr(i+1,j));

        lambda_x = abs(prim.u(i,j)) + prim.a(i,j);

        lambda_r = abs(prim.v(i,j)) + prim.a(i,j);

        dt_cell = CFL / (lambda_x/dx_local + lambda_r/dr_local );

        dt = min(dt,dt_cell);

    end

end

end
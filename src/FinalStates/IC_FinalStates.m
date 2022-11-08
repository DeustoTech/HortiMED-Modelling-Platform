function r = IC_FinalStates(IC)

r.T0 = [IC.Temp.Tcover(end) IC.Temp.Tair(end) IC.Temp.Tfloor(end) IC.Temp.Tsoil(end)];
r.G0 = [IC.Gas.C_w(end) IC.Gas.C_c(end)];

end


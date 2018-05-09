`include "vlib/standar_lib.v"
/* Generated by Yosys 0.7 (git sha1 61f6811, gcc 6.2.0-10 -O2 -fdebug-prefix-map=/build/yosys-0DEyT5/yosys-0.7=. -fstack-protector-strong -fPIC -Os) */

(* top =  1  *)
(* src = "reg_desplazante.v:1" *)
module reg_desplazante(CLK, ENB, DIR, S_IN, MODO, D, Q, S_OUT);
  (* src = "reg_desplazante.v:12" *)
  wire [3:0] _000_;
  (* src = "reg_desplazante.v:12" *)
  wire _001_;
  wire _002_;
  wire _003_;
  wire _004_;
  wire _005_;
  wire _006_;
  wire _007_;
  wire _008_;
  wire _009_;
  wire _010_;
  wire _011_;
  wire _012_;
  wire _013_;
  wire _014_;
  wire _015_;
  wire _016_;
  wire _017_;
  wire _018_;
  wire _019_;
  wire _020_;
  wire _021_;
  wire _022_;
  wire _023_;
  wire _024_;
  wire _025_;
  wire _026_;
  wire _027_;
  wire _028_;
  wire _029_;
  wire _030_;
  wire _031_;
  wire _032_;
  wire _033_;
  wire _034_;
  wire _035_;
  wire _036_;
  wire _037_;
  wire _038_;
  wire _039_;
  wire _040_;
  wire _041_;
  wire _042_;
  wire _043_;
  wire _044_;
  wire _045_;
  wire _046_;
  wire _047_;
  wire _048_;
  wire _049_;
  wire _050_;
  wire _051_;
  wire _052_;
  wire _053_;
  wire _054_;
  wire _055_;
  wire _056_;
  wire _057_;
  wire _058_;
  wire _059_;
  wire _060_;
  wire _061_;
  wire _062_;
  (* src = "reg_desplazante.v:2" *)
  input CLK;
  (* src = "reg_desplazante.v:7" *)
  input [3:0] D;
  (* src = "reg_desplazante.v:4" *)
  input DIR;
  (* src = "reg_desplazante.v:3" *)
  input ENB;
  (* src = "reg_desplazante.v:6" *)
  input [1:0] MODO;
  (* src = "reg_desplazante.v:8" *)
  output [3:0] Q;
  (* src = "reg_desplazante.v:5" *)
  input S_IN;
  (* src = "reg_desplazante.v:9" *)
  output S_OUT;
  NAND _063_ (
    .A(MODO[1]),
    .B(MODO[0]),
    .Y(_002_)
  );
  NAND _064_ (
    .A(_002_),
    .B(ENB),
    .Y(_003_)
  );
  NOT _065_ (
    .A(_003_),
    .Y(_004_)
  );
  NOR _066_ (
    .A(_004_),
    .B(Q[0]),
    .Y(_005_)
  );
  NOT _067_ (
    .A(MODO[0]),
    .Y(_006_)
  );
  NOT _068_ (
    .A(MODO[1]),
    .Y(_007_)
  );
  NAND _069_ (
    .A(_007_),
    .B(_006_),
    .Y(_008_)
  );
  NAND _070_ (
    .A(DIR),
    .B(Q[1]),
    .Y(_009_)
  );
  NOT _071_ (
    .A(_009_),
    .Y(_010_)
  );
  NOT _072_ (
    .A(S_IN),
    .Y(_011_)
  );
  NOR _073_ (
    .A(_011_),
    .B(DIR),
    .Y(_012_)
  );
  NOR _074_ (
    .A(_012_),
    .B(_010_),
    .Y(_013_)
  );
  NOR _075_ (
    .A(_013_),
    .B(_008_),
    .Y(_014_)
  );
  NOR _076_ (
    .A(MODO[1]),
    .B(_006_),
    .Y(_015_)
  );
  NOT _077_ (
    .A(DIR),
    .Y(_016_)
  );
  NAND _078_ (
    .A(_016_),
    .B(Q[3]),
    .Y(_017_)
  );
  NAND _079_ (
    .A(_017_),
    .B(_009_),
    .Y(_018_)
  );
  NAND _080_ (
    .A(_018_),
    .B(_015_),
    .Y(_019_)
  );
  NOT _081_ (
    .A(D[0]),
    .Y(_020_)
  );
  NAND _082_ (
    .A(MODO[1]),
    .B(_006_),
    .Y(_021_)
  );
  NOR _083_ (
    .A(_021_),
    .B(_020_),
    .Y(_022_)
  );
  NOR _084_ (
    .A(_022_),
    .B(_003_),
    .Y(_023_)
  );
  NAND _085_ (
    .A(_023_),
    .B(_019_),
    .Y(_024_)
  );
  NOR _086_ (
    .A(_024_),
    .B(_014_),
    .Y(_025_)
  );
  NOR _087_ (
    .A(_025_),
    .B(_005_),
    .Y(_000_[0])
  );
  NAND _088_ (
    .A(_003_),
    .B(Q[1]),
    .Y(_026_)
  );
  NOR _089_ (
    .A(_007_),
    .B(MODO[0]),
    .Y(_027_)
  );
  NAND _090_ (
    .A(_027_),
    .B(D[1]),
    .Y(_028_)
  );
  NOT _091_ (
    .A(Q[2]),
    .Y(_029_)
  );
  NAND _092_ (
    .A(_029_),
    .B(DIR),
    .Y(_030_)
  );
  NOR _093_ (
    .A(Q[0]),
    .B(DIR),
    .Y(_031_)
  );
  NOR _094_ (
    .A(_031_),
    .B(MODO[1]),
    .Y(_032_)
  );
  NAND _095_ (
    .A(_032_),
    .B(_030_),
    .Y(_033_)
  );
  NAND _096_ (
    .A(_033_),
    .B(_028_),
    .Y(_034_)
  );
  NAND _097_ (
    .A(_034_),
    .B(ENB),
    .Y(_035_)
  );
  NAND _098_ (
    .A(_035_),
    .B(_026_),
    .Y(_000_[1])
  );
  NAND _099_ (
    .A(_003_),
    .B(Q[2]),
    .Y(_036_)
  );
  NAND _100_ (
    .A(_027_),
    .B(D[2]),
    .Y(_037_)
  );
  NOR _101_ (
    .A(_016_),
    .B(Q[3]),
    .Y(_038_)
  );
  NOR _102_ (
    .A(DIR),
    .B(Q[1]),
    .Y(_039_)
  );
  NOR _103_ (
    .A(_039_),
    .B(_038_),
    .Y(_040_)
  );
  NAND _104_ (
    .A(_040_),
    .B(_007_),
    .Y(_041_)
  );
  NAND _105_ (
    .A(_041_),
    .B(_037_),
    .Y(_042_)
  );
  NAND _106_ (
    .A(_042_),
    .B(ENB),
    .Y(_043_)
  );
  NAND _107_ (
    .A(_043_),
    .B(_036_),
    .Y(_000_[2])
  );
  NOR _108_ (
    .A(_004_),
    .B(Q[3]),
    .Y(_044_)
  );
  NOR _109_ (
    .A(_029_),
    .B(DIR),
    .Y(_045_)
  );
  NOR _110_ (
    .A(_011_),
    .B(_016_),
    .Y(_046_)
  );
  NOR _111_ (
    .A(_046_),
    .B(_045_),
    .Y(_047_)
  );
  NOR _112_ (
    .A(_047_),
    .B(_008_),
    .Y(_048_)
  );
  NAND _113_ (
    .A(Q[2]),
    .B(_016_),
    .Y(_049_)
  );
  NAND _114_ (
    .A(Q[0]),
    .B(DIR),
    .Y(_050_)
  );
  NAND _115_ (
    .A(_050_),
    .B(_049_),
    .Y(_051_)
  );
  NAND _116_ (
    .A(_051_),
    .B(_015_),
    .Y(_052_)
  );
  NOT _117_ (
    .A(D[3]),
    .Y(_053_)
  );
  NOR _118_ (
    .A(_021_),
    .B(_053_),
    .Y(_054_)
  );
  NOR _119_ (
    .A(_054_),
    .B(_003_),
    .Y(_055_)
  );
  NAND _120_ (
    .A(_055_),
    .B(_052_),
    .Y(_056_)
  );
  NOR _121_ (
    .A(_056_),
    .B(_048_),
    .Y(_057_)
  );
  NOR _122_ (
    .A(_057_),
    .B(_044_),
    .Y(_000_[3])
  );
  NAND _123_ (
    .A(_003_),
    .B(S_OUT),
    .Y(_058_)
  );
  NAND _124_ (
    .A(_050_),
    .B(_017_),
    .Y(_059_)
  );
  NOT _125_ (
    .A(ENB),
    .Y(_060_)
  );
  NOR _126_ (
    .A(_008_),
    .B(_060_),
    .Y(_061_)
  );
  NAND _127_ (
    .A(_061_),
    .B(_059_),
    .Y(_062_)
  );
  NAND _128_ (
    .A(_062_),
    .B(_058_),
    .Y(_001_)
  );
  DFF _129_ (
    .C(CLK),
    .D(_000_[0]),
    .Q(Q[0])
  );
  DFF _130_ (
    .C(CLK),
    .D(_000_[1]),
    .Q(Q[1])
  );
  DFF _131_ (
    .C(CLK),
    .D(_000_[2]),
    .Q(Q[2])
  );
  DFF _132_ (
    .C(CLK),
    .D(_000_[3]),
    .Q(Q[3])
  );
  DFF _133_ (
    .C(CLK),
    .D(_001_),
    .Q(S_OUT)
  );
endmodule
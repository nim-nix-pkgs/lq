{
  description = ''Directory listing tool'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-lq-1_0_1.flake = false;
  inputs.src-lq-1_0_1.ref   = "refs/tags/1.0.1";
  inputs.src-lq-1_0_1.owner = "madprops";
  inputs.src-lq-1_0_1.repo  = "lq";
  inputs.src-lq-1_0_1.type  = "github";
  
  inputs."nap".owner = "nim-nix-pkgs";
  inputs."nap".ref   = "master";
  inputs."nap".repo  = "nap";
  inputs."nap".dir   = "v3_0_0";
  inputs."nap".type  = "github";
  inputs."nap".inputs.nixpkgs.follows = "nixpkgs";
  inputs."nap".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  inputs."parsetoml".owner = "nim-nix-pkgs";
  inputs."parsetoml".ref   = "master";
  inputs."parsetoml".repo  = "parsetoml";
  inputs."parsetoml".dir   = "v0_6_0";
  inputs."parsetoml".type  = "github";
  inputs."parsetoml".inputs.nixpkgs.follows = "nixpkgs";
  inputs."parsetoml".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-lq-1_0_1"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-lq-1_0_1";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}
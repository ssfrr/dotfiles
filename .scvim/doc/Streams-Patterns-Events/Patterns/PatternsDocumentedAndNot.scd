Patterns in bold are included in Pattern tests
Patterns underlined have help pages
Patterns italicized have been tested but not included in the Pattern tests page.

[
  FilterPattern
  [
    PfadeIn
      [ PfadeOut ]
    Pavaroh
    PdegreeToKey
    Pseed
    Prewrite
    Ptrace
    Pwrap
    Pstutter
      [ PdurStutter ]
    Pbindf
    Plag
    Pconst
    Psync
    Pfindur
    Pfin
    Pplayer
    Pstretch
      [ Pstretchp ]
    Pset
    [
      Psetp
        [ Pmulp Paddp ]
      Pmul
      Padd
    ]
    Psetpre
      [ Pmulpre Paddpre ]
    FuncFilterPattern
      [ Pwhile Pfset Preject Pselect Pcollect ]
    Pn
      [ Ploop ]
  ]
  Phid
  Pdict
  Pdefn
  [
    Tdef
      [ Pdef ]
  ]
  Pswitch
    [ Pswitch1 ]
  ListPattern
  [
    Pwalk
    Pslide
    Ptuple
    Ppar
      [ Ptpar ]
    Pdfsm
    Pfsm
    Pwrand
    Pxrand
    Prand
    Pshuf
    Pseq
      [ Ppatlace Place Pser ]
  ]
  Pindex
  Ppatmod
  Plazy
  Pstatbalnorm
  Pstatbal
  PstepNfunc
    [ PstepNadd ]
  Pstep3add
  Pstep2add
  Pwhite
  Pbrown
  Pgeom
  Pseries
  Pbind
  Pevent
  Pnaryop
  Pbinop
  Punop
  Pfuncn
  Prout
  Proutine
  Pfunc
  
  
  The following lists all the Pattern classes where
embedInStream uses the default Pattern-embedInStream.
These create a new stream whenever embedded.

(
var look;

look = { arg class;
	class.subclasses.do({arg class; 
		if (class.findMethod(\embedInStream).isNil) { 
			class.postln;
			look.value(class);
		};
	});
};

look.value(Pattern);
)



// base classes support both approaches:
FilterPattern
FuncFilterPattern
ListPattern

// classes not reimplemented
Ptrace
Pconst
Pdict
Pstatbalnorm
Pstatbal




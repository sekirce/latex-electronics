#import "@preview/pergamon:0.5.0": *
#import "lib.typ": *

#show: note.with(
  title: [Notes about Synopsys EDA Tools and gm/Id methodology],
  authors: (
    ([Aleksandar Vuković], []),
  ),
  highlight-by: "Vuković",
  version: [1],
)

#abstract[
  About Custom Compiler of the Synopsys EDA:

  I prefer schematic entry features of CC. Probing is more efficient, adding stubs to instances as well, lot of QoL stuff like these dynamic alignment guides, and finally most tool options are not hidden under F3 (as in Virtuoso) and show on the toolbar instead.
]

= Synopsys Custom Compiler

Synopsys Custom Compiler

Utilities -> Compare Design (compare two schematics)

Custom Compiler annotates currents and voltages from simulation onto the layout to enable electromigration and voltage-dependent design rule checking during layout creation.

ROP Annotations

// Here is some math:

/*$
cal(L)(theta) = sum_(u in cal(U)) sum_(g=1)^K (
  P(g|D^((u)); theta_((i-1))) dot.c (
    log P(g|pi) + sum_(d in D_u) log P(b_d|s_d; rho^((g)))
  )
) 
$ <eq:5>

#lorem(20)

Here's an example citation: #citet("ehop-2025").

Here's a reference to another section: @sec:2.
*/

== Usefull command Line Options

//#list[
+ runlvl 1-6 (1 best performance, 6 best accuracy)
+ rcred 1-3 (0 no reduction, 3 most aggro reduction)
//]

= Integrated PrimeWave™ Design Environment

Integrated PrimeWave is a comprehensive and flexible environment for setup, run and debug for corners, multi-testbench sweeps, Monte Carlo, Aging/EMIR, and other analyses.

Single testbench simulations:

- Parametric analysis
- Corner analysis
- Multiple testbench simulations
- Monte Carlo analysis
- Aging and reliability analysis
- Device checks
- Physically aware design checks
    
Allow OP Optimization

Annotate DC Operating Point -- Results > Annotate > Advanced

= PrimeSim™ HSPICE® simulator

hspice Direct, and hSpice Socket
HSPICE can use verilog models

visually-assisted automation (VAA) flow

can use early parasitics to avoid layout rework // how to add.

Synopsys uses TCL instead of Ocean scripts. (Tcl can be used both as an embeddable scripting language and as a general programming language)

Uses PyCells for what? (instead of what in Cadence)

as we at Synopsys did not dogfood it and used custom text-based DSLs for all simulations instead.

== Saving the Simulation State
Session > Save State

OpenAccess

== Analyses

Types:
//#list[
+ tran
+ op
+ ac
+ dc 
+ noise 
+ lin //difference between lin and ac
//]

// comparison with cadence tools

// = Another Section
// <sec:2>

= gm/Id methodology 

To check if the fab is good enough, plot gm/Id from weak inversion to moderate inversion to strong inversion. (Moderate inversion modeling can be bad in small fabs)

Long channel devices can have operation split into 4 modes subthreshold, linear, triode and saturation.

== Subthreshold operation//mode

MOSFET behaves like a BJT (Bipolar Junction Transistor) with a capacitive divider n on the base of the BJT.

Sub-threshold operation is important for limiting the gain of linear high-gain amplifiers. //How? Maybe low-power and high gain.

Application in ultra low power circtuits.

== Saturation operation//mode

Can be caused by velocity saturation or pinch-off.

Saturation mode starts at 3$V_T$ for weak inversion, and goes below $V_"ov"$ for velocity saturation.

// What is the correlation between going into strong inversion and velocity satutration. One comes from Vgs-Vth, and the other ocmes from voltage between source and drain.

There is no precise velocity saturation $V_"crit"$. It happens gradually

$
  I_D prop W / L^beta V_"ov" ^ alpha
$

// in latex its \propto , it means proportional to

$Beta$ is between 0 and 1, and $alpha$ is between 1 and 2.
// a.k.a alpha-law

// There is partial velocity saturation

// Integral example 
// integral_a^b f(x) dif x

So instead of $V^star$

$Lambda$ which is channel length modultaion coefficient. // name seems wrong for short-channel devices.

=== Weak dependance on the $V_"DS"$

== Factor alpha

K = (W/$alpha$L) $mu$ $C_"ox"$

It affects the coefficient for all operation modes.

== GIDL 

- Gate Induced Drain Leakage //models behaviour, I_D characteristic in weak inversion.
  
High $V_"GD"$ can cause current by generating electron-hole pairs.

Why does $I_D$ saturates, is it because of pinch-off or velocity saturation?

$V_"ds"$ is ill-defined (not easy to see or understand)

Most important mismatch in MOS devices is threshold voltage mismatch. The same goes for variations.

Errors in design can be systematic and random. Random errors are usually correspond to mismatch.

Systematic is $V_"DS"$.

$
  g_m/I_d = ?
$

replacement for overdrive voltage.

$
  V^\*= 200 "mV" (V_"ov")
$

$
  g_m/I_d = 2/ V^\* = 10
$

$ 
  I_"out1" = I_"out2" = 100 mu A
$

$
  R_"S1" = 10 Omega
$

== Low phase margin

This can mean noise amplification

Second order system is faster than first order system. Because 90 deg phase margin is slower than ~70 deg one.

== Solving problems of headroom for cascode mirror

How to decrease offset.

strong inversion -> channel length modulation -> more drain-source voltage -> less effective transistor length -> drain current 
all regions -> DIBL -> more drain-source voltage -> less threshold voltage -> more overdrive voltage -> more drain current

CLM and and DIBL have the same effect, so they can be lumped into the same parameter Early voltage $V_A$.

== Harmonic Distortion weak vs strong inversion

In addition, operation in the weak 9 inversion region can also lead to lower harmonic distortion than normally achieved in strong inversion operation [6] of devices. Such performance by the proposed op amp is well-suited for low-power instrumentation applications requiring multiple amplifiers as often found in biomedical applications [2], [12].

How to calculate harmonic distortion in op amps?

[6] D. J. Comer and D. T. Comer, “Using the weak inversion region to optimize input stage design of cmos op amps,” IEEE Transactions on Circuits and Systems-Part 2, vol. 51, pp. 8-14, 2004. xi, 2, 7, 10, 15, 16

[2] L. Fay, V. Misra, and R. Sarpeshkar, “A micropower electrocardiogram amplifier,” IEEE Transactions on Biomedical Circuits and Systems, vol. 3, pp. 312-320, 2009. 2, 7, 10

[12] M. Mollazadeh, K. Murari, G. Cauwenberghs, and N.Thakor, “Micropower cmos integrated low-noise amplification,filtering, and digitization of multimodal neuropotentials,” IEEE Transactions on Biomedical Circuits and Systems, vol. 3, pp. 1-10, 2009. 7, 10

== Square Law

MOSFETs are generally used in strong inversion, where drain current has dependence to gate-source voltage in accordance to square law.

$
  I_D = mu_n C_"ox" W/(2L) (V_"GS"-V_"th")^2(1+lambda (V_"DS" - V_"DSP" ))
$

What is $V_"DSP"$?

== Threshold voltage dependance on $V_"SB"$ 

$
  V_"th" = V_"th0" + gamma (sqrt(2 Phi_F + V_"SB") - sqrt(2 Phi_F))  
$

effect on

//Try to find some examples for quantitive analsys.

== Composite cascode stage

=== Composite vs Conventional cascode stage

It doesn't need additional bias voltage like conventional.

What's the downside?

== Small signal model for weak inversion

Is it possible since it is linear only on a limited voltage range.

== Constant $g_m$ biasing circuit 

== Safe Operating Area

A MOSFET Safe Operating Area (SOA) graph plots drain-source voltage ($V_"DS"$) on the x-axis against drain current ($I_D$) on the y-axis, showing the limits within which the device can operate without damage. The SOA graph is defined by several boundary lines, including limits from breakdown voltage, thermal dissipation, and on-resistance ($R_"DS"$(on)), and is crucial for selecting a MOSFET for applications, especially those involving linear mode operation. The safe area is the region below these boundary lines, where the MOSFET is expected to operate reliably. 

_derate_ - reduce the power rating of a component or device

What is derating of the safe operating area (SOA)?

Calculating the safe operating area according to the ambient temperature (or case temperature) of the semiconductor element.

When the ambient temperature (or case temperature) is $25 degree C$ or more, the allowable loss must be limited so that the junction temperature does not exceed the maximum rating, and the safe operating area becomes narrower.

// How high currents and voltages are at a time?

= Native transistor models

== Use of native transistor models 

There are information out there on the internet but is incredibly sparse to find. Able to roughly get a overall understanding of it from what Igather. Its usage as a moscap or in IO/analog circuits given its x2 to 3 size penalty and additional mask.

Is there papers out there that discussed its origin and usage in current desgins in depth? 

//==============================================================================================

==== Pass transistor in LDO

I had it used once in an LDO design for a VCO as pass device, but besides that I personally haven't seen great use for them, as the leakage is a huge issue 

// probably makes sense for the same supply voltage only decoupled?

//==============================================================================================

=== Lower Ron 

Basically you can control the threshold voltage as you wish because it depends on some doping of the device (with additional mask ofc), the pros of these devices are very fast design as it has lower Ron (higher driving ) than the standard device, that makes sense as Vgs-Vth is higher for 0-V Vth. The cons are they are very leaky, the point is, at 0 gate bias voltage whenever you reduce the threshold voltage, the leakage current will be increased greatly !!!. Also you will need to pay additional mask.

Is it worth? it depends, if you cant get the speed or headroom without then maybe you can go for it, otherwise avoid it whenever possible. 

//==============================================================================================

=== Used in cascodes

I haven't found many a great use for native devices. the only application i used them for was to build cascodes without needing an extra bias voltage. 


=== from other forum

Native vs Standard Vt or Low Vt NMOS

Some background:

Threshold on CMOS can be anything you want it to be.

Anything. It is selectable by the implant doping under the gate region. This is very much a foundry controlled thing. (Also affected by the dielectric of the gate oxide and thickness of the oxide)

PMOS/NMOS thresholds are typically set at 25% to 35% of the voltage between Vdd and ground.

Why these threshold levels?
Logic Design - it gives the best logic immunity to false logic states due to ground bounce and power rail dips.

So called "native" transistors, used to also be known as "depletion" transistors, where the Vth could be near zero, or even negative. (You had to hold the gate to a negative voltage on NMOS to keep the thing turned off)

My experience with foundries has shown that the generic transistors that are commonly used in the digital design are the best controlled, most accurately modeled, devices, just due to foundry priority.

Because of the above fact, I try to avoid using the "native" devices. Better matching? Perhaps, but they data collected needs to be questioned. 

== Miller's Theorem

// General theorem refers to impedence decoupling!? over the constant gain stage

gain A

impedence


== Bode's Noise Theorem

// efficient way to determine total noise in passice RLC

The total integrated noise of any (no matter how complicated) RLC network (interpreted as a one-port) is given by:

$
V^2_n = k T (1/C_infinity-1/C_0)
$

, where $C_infinity$ is the capacitance looking into the network with all resistors and inductors open-circuited, and $C_0$ is the capacitance looking into the circuit when all inductors and resistors are shorted [32]. Reference [32] is an excellent read deriving Bode's noise theorem from different angles.

[32] S. Pavan, “An Alternative Approach to Bode's Noise Theorem,” IEEE Transactions on Circuits and Systems II: Express Briefs, vol. 66, no. 5, pp. 738-742, 2019, doi: 10.1109/TCSII.2019.2907860.

//alternative derivation method

= Rules for Good Mixed-Signal and RF Circuits // these are mostly layout guidelines

- Separate analog and digital power supply, connect to package pins with multiple bond wires/bumps, and separate noisy and clean vdd/vss from each other!

- Prevent supply loops; keep VDD and VSS lines close to each other (incl. bond wires and PCB traces)! This minimizes L and coupling factor k.
//What does it mean close together?

- Some prefer a massive (punched) ground plane, which is possible if you have enough metal levels. With a ground plane, the return path of a signal or supply line is just a few microns away.

- Use chip-internal decoupling capacitors, and decouple bias voltages to the correct potential (vdd or vss, or another node, depending on the circuit)!

- Use substrate contacts and guard rings to lower substrate crosstalk but use a quiet potential for connection; use triple-well if available! Connecting a guard-ring/substrate contact to a noisy supply is a prime noise injector (usually unwanted).

- Physically separate quiet and noisy circuits (at least by the epi thickness)!

- Reduce circuit noise generation as much as possible (avoid switching circuits if possible, use constant-current circuits instead, and use series/shunt regulators for supply isolation).

- Reduce sensitivity of circuits to interference (by using a fully differential design with high PSRR/CMRR, symmetrical layout parasitics, and good matching)

// If the voltage supply limits

// #lorem(50) #cite("knuth1990")


// #add-bib-resource(read("bibliography.bib"))
// #print-bananote-bibliography()
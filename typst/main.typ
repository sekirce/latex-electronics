#import "@preview/pergamon:0.5.0": *
#import "lib.typ": *
#import "@preview/diverential:0.2.0": *

#show: note.with(
  title: [Notes about Synopsys EDA Tools and gm/Id methodology],
  authors: (
    ([Aleksandar Vuković], []),
  ),
  highlight-by: "Vuković",
  version: [1],
)

//==============================================================================================

#abstract[
  About Custom Compiler of the Synopsys EDA:

  I prefer schematic entry features of CC. Probing is more efficient, adding stubs to instances as well, lot of QoL stuff like these dynamic alignment guides, and finally most tool options are not hidden under F3 (as in Virtuoso) and show on the toolbar instead.
]

//==============================================================================================

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

+ runlvl 1-6 (1 best performance, 6 best accuracy)
+ rcred 1-3 (0 no reduction, 3 most aggro reduction)

//==============================================================================================

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

== Operating Point Analysis

Allow OP Optimization
ROP - region of operation
BackAnnottate Operationg Points.


== Shortcuts

Annotate DC Operating Point -- Results > Annotate > Advanced

Setup -> Add Model Files

WaveView - shows plots

ctrl+R - run simulation (once)

//==============================================================================================

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

OpenAccess // how it's saved

== Analyses

Types:
//#list[
+ tran
+ op
+ ac
+ dc 
+ noise 
+ fft // fast fourier transformation
+ lin // What's the difference between lin and ac?
+ acmatch //mismatch?
+ dcmatch
+ trannoise
+ stateye // eye diagram, plotting digital edges
+ lstb // stb in cadence (loop stability)

// comparison with cadence tools

// = Another Section
// <sec:2>

//==============================================================================================
= SKKey Foundry PDK

BCDN = Bipolar Cmos Dmos Non-volotile memory integration // Non-volatile can be used for codes for testability

DMOS == Depletion mode FET normally on. How does it relate to term native transistor. // Native transistor is delpetion-mode transistor made speciffically for V_gs = 0 
Transistor can be enhanced mode.

//==============================================================================================
= Semiconductor physics

$V_"GB"$ causes the inversion not the $V_"GS"$ 

//==============================================================================================
//==============================================================================================
//==============================================================================================

= gm/Id methodology 

To check if the fab is good enough, plot gm/Id from weak inversion to moderate inversion to strong inversion. (Moderate inversion modeling can be bad in small fabs)

Long channel devices can have operation split into 4 modes subthreshold, linear, triode and saturation.

== Subthreshold operation//mode

MOSFET behaves like a BJT (Bipolar Junction Transistor) with a capacitive divider on the base of the BJT.

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

//==============================================================================================

== GIDL 

- Gate Induced Drain Leakage //models behaviour, I_D characteristic in weak inversion.
  
High $V_"GD"$ can cause current by generating electron-hole pairs.

Why does $I_D$ saturates, is it because of pinch-off or velocity saturation?

$V_"ds"$ is an ill-defined (not easy to see or understand).

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

== Small Signal model

When is the linear approximation valid?

$
  Delta V_"GS" << 2 V_"ov"
$

Linearity is a better approximation when in strong inversion. // look at the characteristic I_D over V_GS

=== Long channel $g_m$ dependencies 

Equations:

square law:

$
  I_D = mu_n C_"ox" W/(2L) V_"ov"^2 
$

$g_m$ derivation:

$
  g_m = dvp(I_D, V_"gs") = mu_n C_"ox" W/(L) V_"ov" 
$

$
  V_"ov" = sqrt(2 I_D/(mu_n C_"ox" W/(L)))
$

$
  V_"ov" = sqrt(2 mu_n C_"ox" I_D W/L)
$


Table of dependancies:

#set align(center)
#table(
  columns: (auto, auto, auto),
  inset: 10pt,
  align: horizon,
  table.header(
    [Constant $W$], [Constant $V_"ov"$], [Constant $I_D$],
  ),
    $g_m prop V_"ov"$,
    $g_m prop W$,
    $g_m prop sqrt(W)$,
    $g_m prop sqrt(I_D)$,
    $g_m prop I_D$,
    $g_m prop 1 \/ V_"ov"$
)

#set align(left )

=== $C_"dg"$ and $C_"gd"$ are not the same

$C_"dg" = Delta Q_d/ Delta V_g$

$C_"gd" = Delta Q_g/ Delta V_d$

$
  C_"dg" > C_"gd" 
$

This makes sense because, voltage change on gate affects the drain more than the drain voltage affects the gate charge.

=== Intrinsic gain $g_m r_o$

$
  abs(A_v) = g_m r_o
$

// r_o can be pronounced r_naught which means r nothing like zero

=== Figure of Merit $g_m \/ I_d times f_t$ //It's relatad

Derivation $f_t$

$
  C_"gg" = C_"gb" + C_"gs" + C_"gd"
$

$
  g_m/(2 pi C_"gg") //Is this definition?
$

== Low phase margin

This can mean noise amplification

Second order system is faster than first order system. Because 90 deg phase margin is slower than ~70 deg one.

== Solving problems of headroom for cascode mirror

How to decrease offset.

// Drain induced barrier lowering, How linear is it?

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

//==============================================================================================

== Designer's way of calculating gain of a amplifier stage

$
  G_m = I_"out,sc"/v_"in"
$

$
  A_v = G_m R_"out"
$

== How to memorize the direction of drain current small signal source

It always points the same way as the gate-source voltage.

//==============================================================================================

= Submicron technologies problems//listed

These issues encompass the escalation of detrimental effects like 

- Short Channel Effect (SCE), 
- Gate Induced Drain Leakage (GIDL), 
- diminished low power performance, 
- gate direct tunneling leakage, 
- Drain Induced Barrier Lowering (DIBL), 
- subthreshold leakage current (Ioff) increase, 
- and threshold voltage (Vth) shifts. 

== Composite cascode stage

=== Composite vs Conventional cascode stage

It doesn't need additional bias voltage like conventional.

What's the downside? // How to use native transistor?

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

//==============================================================================================
//==============================================================================================

= Small-signal stability

// from 2001 Striving for small-signal stability

Single-loop theory/multiloop reality is the state-of-the-art of stability analysis [8].

It's still common practice to assess stability from single-loop theory, even though all physical networks in frequency of interest are intrinsically multiloop structures.// Why is this not smart?

Pole-zero analysis is not good for determining stability not only because of the numerical difficulties with large networks.

== Middlebrook's Null Double-Injection Technique

It assumes that signal flows unilaterally.

//Evaluation of true return ratio

== Stability Analysis in a 2 loops system

Hi everyone, having some doubt about stability of system with multi loop.

Let's say I have the circuit in figure (the real one is much more complex, I know that one cannot work for various problem) so I need 2 iprobe to do stb analysis in virtuoso. The 2 current are different and also the 2 error amplifier are different so I will get 2 different loop results from virtuoso.

How to combine them?

=== Answers

My recommendation to a colleague who worked on a fast-loop LDO, was to measure the DC Point for both loops first. To analyze the stability, of one loop, replace the OTA with a DC voltage source with the required quiescent point. Measure its stability. Repeat for second loop.

If both loops seem stable, the final takeaway will always be a “large-signal” transient.

// What if one of the loops is unstable.

== Common RF Circuit Stability simulations

Designers can verify unconditional stability across a wide range of frequencies by simulating factors like the K-factor and stability circles.

//==============================================================================================
//==============================================================================================

= About noise

== Important Properties of Thermal Noise

+ Thermal noise is present in any conductor
+ Thermal noise is independent of DC current flow // Similar to mismatch
+ The power generated by thermal noise is spread up to very high frequencies (1 / τ ≈ 6 Ttad seconds)
+ The only predictable property of thermal noise is its average power
+ The so-called power spectral density shows how much the signal carries at a particular frequency
+ In the case of thermal noise, the power is spread uniformly up to very high frequency (about a 10% drop at 2 THz)
+ The spectral content of the thermal noise is 'white', meaning that power spectral density of thermal noise is constant over the whole frequency range


== Bode's Noise Theorem

// efficient way to determine total noise in passice RLC

The total integrated noise of any (no matter how complicated) RLC network (interpreted as a one-port) is given by:

$
V^2_n = k T (1/C_infinity-1/C_0)
$

, where $C_infinity$ is the capacitance looking into the network with all resistors and inductors open-circuited, and $C_0$ is the capacitance looking into the circuit when all inductors and resistors are shorted [32]. Reference [32] is an excellent read deriving Bode's noise theorem from different angles.

[32] S. Pavan, “An Alternative Approach to Bode's Noise Theorem,” IEEE Transactions on Circuits and Systems II: Express Briefs, vol. 66, no. 5, pp. 738-742, 2019, doi: 10.1109/TCSII.2019.2907860.

//alternative derivation method

= Native transistor models //subgroup of depletion mode transistor

== Use of native transistor models 

There are information out there on the internet but is incredibly sparse to find. Able to roughly get a overall understanding of it from what Igather. Its usage as a moscap or in IO/analog circuits given its x2 to 3 size penalty and additional mask.

Is there papers out there that discussed its origin and usage in current desgins in depth? 

//==============================================================================================

==== Pass transistor in LDO

I had it used once in an LDO design for a VCO as pass device, but besides that I personally haven't seen great use for them, as the leakage is a huge issue 

// probably makes sense for the same supply voltage only decoupled?

// how to calculate PSRR for a LDO circuit which has no gain

//==============================================================================================

=== Lower Ron 

Basically you can control the threshold voltage as you wish because it depends on some doping of the device (with additional mask ofc), the pros of these devices are very fast design as it has lower Ron (higher driving ) than the standard device, that makes sense as Vgs-Vth is higher for 0-V Vth. The cons are they are very leaky, the point is, at 0 gate bias voltage whenever you reduce the threshold voltage, the leakage current will be increased greatly !!!. Also you will need to pay additional mask.

Is it worth? it depends, if you cant get the speed or headroom without then maybe you can go for it, otherwise avoid it whenever possible. 

//==============================================================================================

=== Used in cascodes

I haven't found many a great use for native devices. the only application I used them for was to build cascodes without needing an extra bias voltage. 

//==============================================================================================

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

Defined by equations:

$
  Z_1 = Z/(1-A)
$

$
  Z_2 = Z/(1-1/A)
$

Where gain A is voltage gain.


= Measurement tips for LDO Regulator // Linear DropOut regulator

+ V_out transient peak overshot and undershoot

+ Vout transient: peak undershoot/overshoot (mV), settling time to ±1% (or tighter).

+ $I_"load"$ actual shape (ensure your source bandwidth is as intended). // how to model 

+ Phase margin proxy: ringing frequency & damping; confirm with AC loop break if possible. //

+ Thermal: power in pass device $ P approx (V_"IN"-V_"OUT")⋅I_"LOADP" approx (V_"IN"-V_"OUT")\cdot I_"LOADP"≈(V_"IN"-V_"OUT")⋅I_"LOAD". $

+ Dropout: sweep Vin down under max load; define dropout point at Vout deviation threshold (e.g., -100 mV).

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
// 

= Bandgap ideas


= Open-Source EDA Tools

Guidelines by

== Install prerequisites // things that are required beforehand

'''shell
\$ sudo apt-get install git
\$ sudo apt-get install build-essential // is a meta-package that has gcc g++ make (build automation tools) dpkg-dev (debian package development tools) libc6-dev
\$ sudo apt-get install libxrender-dev libx11-xcb-dev libcairo2-dev tcl8.6-dev tk8.6-dev bison libxpm-dev libjpeg-dev libxrender1 libxcb1 libcairo2 tcl8.6 tk8.6 flex libxpm4 libjpeg62-turbo xterm vim-gtk3 gawk tcl-tclreadline  // this will install all required libs, development and headers files needed to compile and build XSCHEM
'''

// bison and flex are parsing tools

''' shell
\$ sudo apt install libxaw7-dev
'''

== Xschem

used in simulation configuration for Xschem

```
$terminal -e 'set -o pipefail; (ngspice -b -r "$n.raw" "$N" | tee "$n.out") || (echo -e "\n** ngspice exited with error code $? **\nPress enter to close"; read)'
```

If you do use that line, I recommend keeping Fg checked and Status unchecked. With that setup you will get a terminal showing that keeps you apprised on the simulation progress. The terminal will auto-close if the simulation was successful, which in the long run saves you time and energy.

When you are finished with the simulator setup, press "Accept and close"
Simulating the design

TODO: Describe

In summary:

- Press Netlist, then Simulate, then Waves.
- Select a net, e.g. inv_out and press Alt+G to show it in Gaw.

=== Options Netlist format / Symbol mode
set to Spice Netlist

== magic

VLSI layout

alternative is KLayout, but it does not have instantiation from spice schematics.

== ngspice

ngspice ie open-source, made by Barkley now ngspice team.

Origins are spice3f5, XSPICE and CIDER.

Precedence of option and .options commands
- no option, than default values are given for each simulation
- spinit or .spiceinit
- if you set options by .control, those supersede any simulator variables given so far 

If variable appendwrite is set, the data may be added to an existing file.

Backannotate can be done:

```
name=h1
descr=Backannotate
tclcommand="xschem annotate_op"
```
or:
```
name=h1
descr=Backannotate
tclcommand="set show_hidden_texts 1; xschem annotate_op"
```

=== Error while building ng-spice

runing *make* command returns error // problem might be with the prerequisite libraries

```
gcc -O2 -s -Wall -Wextra -Wmissing-prototypes -Wstrict-prototypes -Wnested-externs -Wold-style-definition -Wredundant-decls -Wconversion -Wno-unused-but-set-variable -std=gnu11 -fopenmp -I../../../../src/xspice/icm/../../include -I/mnt/c/Users/alvukovi/OneDrive - Capgemini/Documents/gitClones/ngspice_git/release/src/xspice/icm/../../include -fPIC -o dstring.o -c ../../../../src/xspice/icm/../../misc/dstring.c
gcc: fatal error: cannot specify '-o' with '-c', '-S' or '-E' with multiple files
compilation terminated.
```

=== Shortcuts and Examples for ngspice

Comment out a line with \*


== openpdk

== Plot viewer 
gaw in schematic


= Calculate input capacitance

To calculate input capacitance in Cadence Virtuoso, use an AC analysis to find current/voltage ratio or a Transient analysis with \(C=I/(dV/dt)\) for large signals, leveraging the Calculator for formulas like imag(Y(1,1))/(2*pi*freq) or by measuring current with a large cap at the node. The best method depends on whether you need small-signal (AC) or large-signal (Transient) capacitance, often involving setting up AC ports and using the Results Browser or Calculator.

Method 1: AC Analysis (Small-Signal Capacitance) 

- Set up AC analysis: In the ADE setup, add an AC source (e.g., 1V AC magnitude) to the input net.

- Run Simulation: Perform an AC simulation.Use Calculator:In the Calculator, select "Y-Matrix" (Admittance).For the input node (node 1), use the formula: imag(Y(1,1))/(2*pi*freq).

- Alternatively, use $ I_g / (2*pi*"freq"*1V)$ if you measured input current ($I_g$) at 1V.

= Agentic AI - training

Has ability to operate autonomously in complex environments, decision-making over content creation and do not require human prompts or continuous oversight.

how budgets are shifting from passive analytics to AI that actually acts

LLM - large language models

P-R-A-L Perceive Reason Act Learn (this is not done by a LLM AIs like chatGPT, it only does the Reason part)

ERP (Enterprise Resource Planning) system is a software that integrates and automates an organization's core business processes, such as finance, HR, manufacturing, and supply chain management, into a single, unified platform with a common database.

*autonomy* to make decisions

capacity to act (*agency*)

defined *authority*


= Text for Capgemini Newsletter description

Hi, I'm an Analog Design Engineer with 7 years of experience in Analog and RF IC design across communication, automotive, and product-driven industries. I'm committed to continuous learning and innovation, always striving to enhance my skills and deliver high-quality solutions. Outside of work, I enjoy swimming and unwinding with movies and TV shows.

Electronics and Semicon Engineer | Analog Design | Serbia





/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 2;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const unsigned int gappih    = 20;       /* horiz inner gap between windows */
static const unsigned int gappiv    = 20;       /* vert inner gap between windows */
static const unsigned int gappoh    = 20;       /* horiz outer gap between windows and screen edge */
static const unsigned int gappov    = 20;       /* vert outer gap between windows and screen edge */
static       int smartgaps          = 0;        /* 1 means no outer gap when there is only one window */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const int vertpad            = 5;       /* vertical padding of bar */
static const int sidepad            = 5;       /* horizontal padding of bar */
static const char *fonts[]          = { "JetBrainsMono Nerd Font:size=10" };
static const char dmenufont[]       = "JetBrainsMono Nerd Font:size=10";
static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#282828";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#988B79";
static const char col1[]    		= "#FAE3B0";
static const char col2[]     		= "#181818";
static const char col3[]     		= "#bbbbbb";
static const char col4[]     		= "#bbbbbb";
static const char *colors[][3]      = {
  /*               fg         bg         border   */
  [SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
  [SchemeSel]  = { col_gray4, col1,  col_cyan  },
  [SchemeStatus]  = { col1, col2,  "#000000"  }, // Statusbar right {text,background,not used but cannot be empty}
  [SchemeTagsSel]  = { col2, col1,  "#000000"  }, // Tagbar left selected {text,background,not used but cannot be empty}
  [SchemeTagsNorm]  = { col1, col2,  "#000000"  }, // Tagbar left unselected {text,background,not used but cannot be empty}
  [SchemeInfoSel]  = { col3, col2,  "#000000"  }, // infobar middle  selected {text,background,not used but cannot be empty}
  [SchemeInfoNorm]  = { col1, col2,  "#000000"  }, // infobar middle  unselected {text,background,not used but cannot be empty}
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
/* xprop(1):
*	WM_CLASS(STRING) = instance, class
*	WM_NAME(STRING) = title
*/
  /* class      instance    title       tags mask     isfloating   monitor */
  { "Gimp",     NULL,       NULL,       0,            1,           -1 },
  { "Firefox",  NULL,       NULL,       0,       0,           -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */

#define FORCE_VSPLIT 1  /* nrowgrid layout: force two clients to always split vertically */
#include "vanitygaps.c"

static const Layout layouts[] = {
  /* symbol     arrange function */
  { "[@]",      spiral },    /* first entry is default */
  { "[]=",      tile },
  { "|M|",      centeredmaster },
  { "[M]",      monocle },
  { "[\\]",     dwindle },
  // 	{ "H[]",      deck },
  // 	{ "TTT",      bstack },
  // 	{ "===",      bstackhoriz },
  { "HHH",      grid },
  // 	{ "###",      nrowgrid },
  // 	{ "---",      horizgrid },
  // 	{ ":::",      gaplessgrid },
  //
  // 	{ ">M>",      centeredfloatingmaster },
  { "><>",      NULL },    /* no layout function means floating behavior */
  { NULL,       NULL },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col2, "-nf", col4, "-sb", col1, "-sf", col2, NULL };
static const char *termcmd[]  = { "st", NULL };
static const char *browser[]  = { "firefox", NULL };

static Key keys[] = {
  /* modifier                     key        function        argument */
  { MODKEY,                       XK_space,  spawn,          {.v = dmenucmd } },
  { MODKEY,                       XK_Return, spawn,          {.v = termcmd } },
  { MODKEY,                       XK_f,      spawn,          SHCMD("st -e nnn") },

  { MODKEY,                       XK_g,      spawn,          {.v = browser } },
  { MODKEY,                       XK_Print,  spawn,          SHCMD("scrot /home/daisn/screenshot/x.png") },
  { MODKEY|ShiftMask,             XK_Print,  spawn,          SHCMD("scrot -s /home/daisn/screenshot/x.png") },
  { MODKEY,                       XK_m,      spawn,          SHCMD("st -e mocp") },
  { MODKEY,                       XK_b,      togglebar,      {0} },

  { MODKEY|ShiftMask,             XK_j,      rotatestack,    {.i = +1 } },
  { MODKEY|ShiftMask,             XK_k,      rotatestack,    {.i = -1 } },

  { MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
  { MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
  { MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
  { MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
  { MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
  { MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
  { MODKEY|ShiftMask,             XK_Return, zoom,           {0} },

  { MODKEY|Mod1Mask,              XK_u,      incrgaps,       {.i = +1 } },
  { MODKEY|Mod1Mask|ShiftMask,    XK_u,      incrgaps,       {.i = -1 } },
  { MODKEY|Mod1Mask,              XK_i,      incrigaps,      {.i = +1 } },
  { MODKEY|Mod1Mask|ShiftMask,    XK_i,      incrigaps,      {.i = -1 } },
  { MODKEY|Mod1Mask,              XK_o,      incrogaps,      {.i = +1 } },
  { MODKEY|Mod1Mask|ShiftMask,    XK_o,      incrogaps,      {.i = -1 } },
  { MODKEY|Mod1Mask,              XK_6,      incrihgaps,     {.i = +1 } },
  { MODKEY|Mod1Mask|ShiftMask,    XK_6,      incrihgaps,     {.i = -1 } },
  { MODKEY|Mod1Mask,              XK_7,      incrivgaps,     {.i = +1 } },
  { MODKEY|Mod1Mask|ShiftMask,    XK_7,      incrivgaps,     {.i = -1 } },
  { MODKEY|Mod1Mask,              XK_8,      incrohgaps,     {.i = +1 } },
  { MODKEY|Mod1Mask|ShiftMask,    XK_8,      incrohgaps,     {.i = -1 } },
  { MODKEY|Mod1Mask,              XK_9,      incrovgaps,     {.i = +1 } },
  { MODKEY|Mod1Mask|ShiftMask,    XK_9,      incrovgaps,     {.i = -1 } },
  { MODKEY|Mod1Mask,              XK_0,      togglegaps,     {0} },
  { MODKEY|Mod1Mask|ShiftMask,    XK_0,      defaultgaps,    {0} },

  { MODKEY,                       XK_Tab,    view,           {0} },
  { MODKEY,                       XK_q,      killclient,     {0} },
  { MODKEY,                       XK_r,      setlayout,      {.v = &layouts[0]} },
  { MODKEY,                       XK_t,      setlayout,      {.v = &layouts[1]} },
  { MODKEY,                       XK_y,      setlayout,      {.v = &layouts[2]} },
  { MODKEY,                       XK_u,      setlayout,      {.v = &layouts[3]} },
  { MODKEY,                       XK_i,      setlayout,      {.v = &layouts[4]} },
  { MODKEY,                       XK_o,      setlayout,      {.v = &layouts[5]} },
  { MODKEY|ControlMask,		      XK_comma,  cyclelayout,    {.i = -1 } },
  { MODKEY|ControlMask,           XK_period, cyclelayout,    {.i = +1 } },
  { MODKEY,                       XK_p,      setlayout,      {0} },
  { MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
  { MODKEY,                       XK_0,      view,           {.ui = ~0 } },
  { MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },

  { MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
  { MODKEY,                       XK_period, focusmon,       {.i = +1 } },
  { MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
  { MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
  { MODKEY,                       XK_F3,     spawn,          SHCMD("bash ~/.dotfiles/scripts/inc_vol.sh")},
  { MODKEY,                       XK_F2,     spawn,          SHCMD("bash ~/.dotfiles/scripts/dec_vol.sh")},
  { MODKEY,                       XK_F4,     spawn,          SHCMD("bash ~/.dotfiles/scripts/mute.sh")},
  { MODKEY|ShiftMask,             XK_p,      spawn,          SHCMD("bash ~/.dotfiles/scripts/themenu.sh")},
  { MODKEY|ShiftMask,             XK_y,      spawn,          SHCMD("bash ~/.dotfiles/scripts/yt.sh")},
  { MODKEY,			              XK_F5,     spawn,          SHCMD("bash ~/.dotfiles/scripts/mpv.sh")},
  { MODKEY,			              XK_F1,     spawn,          SHCMD("bash ~/.dotfiles/scripts/time-date.sh")},
  TAGKEYS(                        XK_1,                      0)
  TAGKEYS(                        XK_2,                      1)
  TAGKEYS(                        XK_3,                      2)
  TAGKEYS(                        XK_4,                      3)
  TAGKEYS(                        XK_5,                      4)
  TAGKEYS(                        XK_6,                      5)
  TAGKEYS(                        XK_7,                      6)
  TAGKEYS(                        XK_8,                      7)
  TAGKEYS(                        XK_9,                      8)
  { MODKEY|ShiftMask,             XK_q,      quit,           {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
  /* click                event mask      button          function        argument */
  { ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
  { ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
  { ClkWinTitle,          0,              Button2,        zoom,           {0} },
  { ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
  { ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
  { ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
  { ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
  { ClkTagBar,            0,              Button1,        view,           {0} },
  { ClkTagBar,            0,              Button3,        toggleview,     {0} },
  { ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
  { ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};


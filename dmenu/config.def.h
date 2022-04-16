/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int topbar = 0;                      /* -b  option; if 0, dmenu appears at bottom     */
static int centered = 1;                    /* -c option; centers dmenu on screen */
static int min_width = 500;                    /* minimum width when centered */
/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = {
  "JetBrainsMono Nerd Font:size=12"
};
static const char *prompt      = NULL;      /* -p  option; prompt to the left of input field */
static const char *colors[SchemeLast][2] = {
  /*     fg         bg       */
  //	[SchemeNorm] = { "#bbbbbb", "#222222" },
  //	[SchemeSel] = { "#eeeeee", "#005577" },
  //	[SchemeOut] = { "#000000", "#00ffff" },
  [SchemeNorm] = { "#fbf1c7", "#000000" },
  [SchemeSel] = { "#000000", "#ABE9B3" },
  [SchemeOut] = { "#fbf1c7", "#8ec07c" },

};
/* -l and -g options; controls number of lines and columns in grid if > 0 */
static unsigned int lines      =15;
static unsigned int columns    = 1;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";

/* Size of the window border */
static const unsigned int border_width = 1;

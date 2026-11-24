/* SPDX-License-Identifier: MIT
 * Copyright (c) 2026 abdulahmad and contributors
 *
 * The box for NHL 97 PC (overbar/box_cd.h): the big box, the manual, the technical reference card, the jewel case and the cards;
 * the first time, the CD into the 486's CD-ROM drive and the game's own installer (DOSSETUP.EXE) on its monitor, screen by screen. The
 * installer's screens are pictures in the player's art folder (box-art/pc97/), like the scans. */
#include <overbar/box_cd.h>

static const bx_cd_step STEPS[] = {
    { CD_TEXT, "d:", 1, 0, 0 },
    { CD_TEXT, "D:\\>", 0, 500, 0 },
    { CD_TEXT, "dossetup", 1, 0, 0 },
    { CD_SCREEN, "inst97a", 0, 2600, 0 },        /* the title: English / Deutsch / Svenska */
    { CD_SCREEN, "inst97b", 0, 2400, 1 },        /* Sound card */
    { CD_SCREEN, "inst97c", 0, 2600, 1 },        /* Install game: C:\NHL97DOS\, Minimum / Recommended / Optimum */
    { CD_COPY, "inst97copy0", 0, 400, 1 },       /* the panel opens on the two bars, the file list scrolls */
    { CD_COPY, "inst97copy1", 0, 500, 0 }, { CD_COPY, "inst97copy2", 0, 700, 0 }, { CD_COPY, "inst97copy3", 0, 700, 0 },
    { CD_COPY, "inst97copy4", 0, 700, 0 }, { CD_COPY, "inst97copy5", 0, 700, 0 }, { CD_COPY, "inst97copy6", 0, 700, 0 },
    { CD_COPY, "inst97copy7", 0, 700, 0 }, { CD_COPY, "inst97copy8", 0, 700, 0 },
    { CD_SCREEN, "inst97shut", 0, 700, 0 },      /* the doors close on the NHL and NHLPA shields */
    { CD_SCREEN, "inst97done", 0, 2600, 0 },     /* Run / Read me / Uninstall / Re-install / Change sound card */
};
const bx_cd_game BOX_PC97 = { "pc97", "NHL 97", 48, 24, STEPS, (int)(sizeof STEPS / sizeof STEPS[0]) };

/*
 * Simple kernel gaming control
 *
 * Copyright (C) 2019
 * Diep Quynh Nguyen <remilia.1505@gmail.com>
 * Mustafa Gökmen <mustafa.gokmen2004@gmail.com>
 *
 * This software is licensed under the terms of the GNU General Public
 * License version 2, as published by the Free Software Foundation, and
 * may be copied, distributed, and modified under those terms.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 */

#ifndef _GAMING_CONTROL_H_
#define _GAMING_CONTROL_H_

enum game_opts {
	GAME_START,
	GAME_RUNNING,
	GAME_PAUSE
};

extern unsigned int min_mif_freq;
extern unsigned int min_little_freq;
extern unsigned int max_little_freq;
extern unsigned int min_big_freq;
extern unsigned int max_big_freq;
extern unsigned int min_gpu_freq;
extern unsigned int max_gpu_freq;

int gpu_custom_power_policy_set(const char *buf);
int gpu_custom_min_clock(int gpu_min_clock);
int gpu_custom_max_clock(int gpu_max_clock);

#ifdef CONFIG_GAMING_CONTROL
extern void game_option(struct task_struct *tsk, enum game_opts opts);
extern bool gaming_mode;
#else
static void game_option(struct task_struct *tsk, enum game_opts opts) {}
static bool gaming_mode = 0;
#endif /* CONFIG_GAMING_CONTROL */

#endif /* _GAMING_CONTROL_H_ */

#!/bin/bash
# run comparison of curriculum learning vs. baseline

# baseline: 5M on easy counterattack
curtime=$(date)
echo "Starting 5M steps of academy_counterattack_hard at $curtime"
python -m torchbeast.monobeast_football \
	--num_actors 64 --use_lstm --num_threads 16 --env academy_counterattack_hard \
	--total_steps 8_000_000 --discounting 0.99 --batch_size 16 \
	--xpid counter_baseline

# --- curriculum --- 
# 1: empty goal close @ 500k
curtime=$(date)
echo "Starting 500k steps of academy_empty_goal_close at $curtime"
python -m torchbeast.monobeast_football \
	--num_actors 64 --use_lstm --num_threads 16 --env academy_empty_goal_close \
	--total_steps 500_000 --discounting 0.99 --batch_size 16 \
	--xpid comp_1

# 3: pass + shoot w/ keeper @ 1M
curtime=$(date)
echo "Starting 1M steps of academy_pass_and_shoot_with_keeper at $curtime"
python -m torchbeast.monobeast_football \
	--num_actors 64 --use_lstm --num_threads 16 --env academy_pass_and_shoot_with_keeper \
	--total_steps 1_000_000 --discounting 0.99 --batch_size 16 \
	--xpid comp_2 --load_checkpoint_weights ~/logs/torchbeast/comp_1/

# 4: 3v1 w/ keeper @ 1.5M
curtime=$(date)
echo "Starting 1.5M steps of academy_3_vs_1_with_keeper at $curtime"
python -m torchbeast.monobeast_football \
	--num_actors 64 --use_lstm --num_threads 16 --env academy_3_vs_1_with_keeper \
	--total_steps 1_500_000 --discounting 0.99 --batch_size 16 \
	--xpid comp_3 --load_checkpoint_weights ~/logs/torchbeast/comp_2/

# 8: run, pass, and shoot w/ keeper @ 2M
curtime=$(date)
echo "Starting 2M steps of academy_run_pass_and_shoot_with_keeper at $curtime"
python -m torchbeast.monobeast_football \
	--num_actors 64 --use_lstm --num_threads 16 --env academy_run_pass_and_shoot_with_keeper \
	--total_steps 2_000_000 --discounting 0.99 --batch_size 16 \
	--xpid comp_4 --load_checkpoint_weights ~/logs/torchbeast/comp_3/

# 10: easy counterattack @ 5M
curtime=$(date)
echo "Starting 5M steps of academy_counterattack_hard at $curtime"
python -m torchbeast.monobeast_football \
	--num_actors 64 --use_lstm --num_threads 16 --env academy_counterattack_hard \
	--total_steps 3_000_000 --discounting 0.99 --batch_size 16 \
	--xpid counter_curriculum --load_checkpoint_weights ~/logs/torchbeast/comp_4/
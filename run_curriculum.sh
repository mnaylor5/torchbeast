#!/bin/bash
# run curriculum of scenarios for Google Research football with modified 
# TorchBeast implementation; to be run in the torchbeast main directory

# 1: empty goal close @ 500k
curtime=$(date)
echo "Starting 500k steps of academy_empty_goal_close at $curtime"
python -m torchbeast.monobeast_football \
	--num_actors 48 --use_lstm --num_threads 16 --env academy_empty_goal_close \
	--total_steps 500_000 --discounting 0.99 --batch_size 8 \
	--xpid curriculum_1

# 2: empty goal @ 500k
curtime=$(date)
echo "Starting 500k steps of academy_empty_goal at $curtime"
python -m torchbeast.monobeast_football \
	--num_actors 48 --use_lstm --num_threads 16 --env academy_empty_goal \
	--total_steps 500_000 --discounting 0.99 --batch_size 8 \
	--xpid curriculum_2 --load_checkpoint_weights ~/logs/torchbeast/curriculum_1/

# 3: pass + shoot w/ keeper @ 3M
curtime=$(date)
echo "Starting 3M steps of academy_pass_and_shoot_with_keeper at $curtime"
python -m torchbeast.monobeast_football \
	--num_actors 48 --use_lstm --num_threads 16 --env academy_pass_and_shoot_with_keeper \
	--total_steps 3_000_000 --discounting 0.99 --batch_size 8 \
	--xpid curriculum_3 --load_checkpoint_weights ~/logs/torchbeast/curriculum_2/

# 4: 3v1 w/ keeper @ 3M
curtime=$(date)
echo "Starting 3M steps of academy_3_vs_1_with_keeper at $curtime"
python -m torchbeast.monobeast_football \
	--num_actors 48 --use_lstm --num_threads 16 --env academy_3_vs_1_with_keeper \
	--total_steps 3_000_000 --discounting 0.99 --batch_size 8 \
	--xpid curriculum_4 --load_checkpoint_weights ~/logs/torchbeast/curriculum_3/

# 5: single goal vs lazy @ 5M
curtime=$(date)
echo "Starting 5M steps of academy_single_goal_versus_lazy at $curtime"
python -m torchbeast.monobeast_football \
	--num_actors 48 --use_lstm --num_threads 16 --env academy_single_goal_versus_lazy \
	--total_steps 5_000_000 --discounting 0.99 --batch_size 8 \
	--xpid curriculum_5 --load_checkpoint_weights ~/logs/torchbeast/curriculum_4/

# 6: run to score @ 3M
curtime=$(date)
echo "Starting 3M steps of academy_run_to_score at $curtime"
python -m torchbeast.monobeast_football \
	--num_actors 48 --use_lstm --num_threads 16 --env academy_run_to_score \
	--total_steps 3_000_000 --discounting 0.99 --batch_size 8 \
	--xpid curriculum_6 --load_checkpoint_weights ~/logs/torchbeast/curriculum_5/

# 7: run to score w/ keeper @ 3M
curtime=$(date)
echo "Starting 3M steps of academy_run_to_score_with_keeper at $curtime"
python -m torchbeast.monobeast_football \
	--num_actors 48 --use_lstm --num_threads 16 --env academy_run_to_score_with_keeper \
	--total_steps 3_000_000 --discounting 0.99 --batch_size 8 \
	--xpid curriculum_7 --load_checkpoint_weights ~/logs/torchbeast/curriculum_6/

# 8: run, pass, and shoot w/ keeper @ 3M
curtime=$(date)
echo "Starting 3M steps of academy_run_pass_and_shoot_with_keeper at $curtime"
python -m torchbeast.monobeast_football \
	--num_actors 48 --use_lstm --num_threads 16 --env academy_run_pass_and_shoot_with_keeper \
	--total_steps 3_000_000 --discounting 0.99 --batch_size 8 \
	--xpid curriculum_8 --load_checkpoint_weights ~/logs/torchbeast/curriculum_7/

# 9: corner kick @ 1M
curtime=$(date)
echo "Starting 1M steps of academy_corner at $curtime"
python -m torchbeast.monobeast_football \
	--num_actors 48 --use_lstm --num_threads 16 --env academy_corner \
	--total_steps 1_00_000 --discounting 0.99 --batch_size 8 \
	--xpid curriculum_9 --load_checkpoint_weights ~/logs/torchbeast/curriculum_8/

# 10: easy counterattack @ 5M
curtime=$(date)
echo "Starting 5M steps of academy_counterattack_easy at $curtime"
python -m torchbeast.monobeast_football \
	--num_actors 48 --use_lstm --num_threads 16 --env academy_counterattack_easy \
	--total_steps 5_000_000 --discounting 0.99 --batch_size 8 \
	--xpid curriculum_10 --load_checkpoint_weights ~/logs/torchbeast/curriculum_9/

# 11: hard counterattack @ 5M
curtime=$(date)
echo "Starting 5M steps of academy_counterattack_hard at $curtime"
python -m torchbeast.monobeast_football \
	--num_actors 48 --use_lstm --num_threads 16 --env academy_counterattack_hard \
	--total_steps 5_000_000 --discounting 0.99 --batch_size 8 \
	--xpid curriculum_11 --load_checkpoint_weights ~/logs/torchbeast/curriculum_10/

# 12: full easy matches @ 8M
curtime=$(date)
echo "Starting 8M steps of 11_vs_11_easy_stochastic at $curtime"
python -m torchbeast.monobeast_football \
	--num_actors 48 --use_lstm --num_threads 16 --env 11_vs_11_easy_stochastic \
	--total_steps 8_000_000 --discounting 0.99 --batch_size 8 \
	--xpid curriculum_12 --load_checkpoint_weights ~/logs/torchbeast/curriculum_11/

# 13: full medium matches @ 10M
curtime=$(date)
echo "Starting 10M steps of 11_vs_11_stochastic at $curtime"
python -m torchbeast.monobeast_football \
	--num_actors 48 --use_lstm --num_threads 16 --env 11_vs_11_stochastic \
	--total_steps 10_000_000 --discounting 0.99 --batch_size 8 \
	--xpid curriculum_13 --load_checkpoint_weights ~/logs/torchbeast/curriculum_12/

# 14: full hard matches @ 10M
curtime=$(date)
echo "Starting 10M steps of 11_vs_11_hard_stochastic at $curtime"
python -m torchbeast.monobeast_football \
	--num_actors 48 --use_lstm --num_threads 16 --env 11_vs_11_hard_stochastic \
	--total_steps 10_000_000 --discounting 0.99 --batch_size 8 \
	--xpid curriculum_14 --load_checkpoint_weights ~/logs/torchbeast/curriculum_13/

# 15: full kaggle matches @ 10M
curtime=$(date)
echo "Starting 10M steps of 11_vs_11_kaggle at $curtime"
python -m torchbeast.monobeast_football \
	--num_actors 48 --use_lstm --num_threads 16 --env 11_vs_11_kaggle \
	--total_steps 10_000_000 --discounting 0.99 --batch_size 8 \
	--xpid curriculum_final --load_checkpoint_weights ~/logs/torchbeast/curriculum_14/
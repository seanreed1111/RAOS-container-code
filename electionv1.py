# cat electionv1.py
import os
import fire

def run_model(name = 'election.stan'):
    from cmdstanpy import cmdstan_path, CmdStanModel

    election_stan = os.path.join(os.getcwd(), name)
    election_model = CmdStanModel(stan_file=election_stan)
    election_data = os.path.join(os.getcwd(), 'election.json')
    election_fit = election_model.sample(data=election_data, output_dir=os.getcwd())
    return  f"election.stan = {election_stan} has been sampled successfully"

if __name__ == '__main__':
    fire.Fire(run_model)

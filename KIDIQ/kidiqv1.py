import os
import fire
from cmdstanpy import cmdstan_path, CmdStanModel

def run_model(model_name = 'kidiq.stan', data_name=None):

    cwd = os.getcwd()
    model_path = os.path.join(cwd, model_name)
    kidiq_model = CmdStanModel(stan_file=model_path)

    # if model is `model_name.stan`, data file should be called `model_name.json`

    data_name = data_name or ("{}.json".format(model_name.split(".")[0]))

    data_path = os.path.join(cwd, data_name)
    kidiq_fit = kidiq_model.sample(data=data_path, output_dir=cwd)
    print(f"model = {model_name} has been sampled successfully")
    print(kidiq_fit.summary())
    return  "the model has been sampled successfully"

if __name__ == '__main__':
    fire.Fire(run_model)

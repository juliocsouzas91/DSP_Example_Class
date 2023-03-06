#Define the images parameters
import matplotlib

def define_plots_settings():
        matplotlib.rcParams['text.usetex'] = True
        matplotlib.rcParams['text.latex.preamble'] = [
                r'\usepackage{amsmath}',
                r'\usepackage{amssymb}']
        matplotlib.rcParams['font.family'] = 'serif'
        matplotlib.rcParams.update({'font.size': 16})
        matplotlib.rcParams['lines.linewidth'] = 2 
        matplotlib.rcParams['font.weight'] = 700        

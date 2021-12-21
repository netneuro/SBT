import numpy as np
from scipy.stats import norm
from matplotlib import pyplot as plt
import seaborn as sns
sns.set()


def kl_divergence(p, q):
    return np.sum(np.where(p != 0, p * np.log(p / q), 0))


x = np.arange(-10, 10, 0.001)
p = norm.pdf(x, 0, 2)
q = norm.pdf(x, 2, 2)
a = 1

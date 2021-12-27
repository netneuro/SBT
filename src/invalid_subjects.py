# Functions used in invalid_subjects.py as my_functions
# Written by: Zahra Mor | Feb 2021

import numpy as np
import math
from scipy import stats


def findSubjectsWithInvalidScantime(count, data, valid_scantime):
    # Finds subjects with less than 5 min scan
    # data = [0: age, 1: fIQ, 2: vIQ, 3: pIQ, 4: TR, 5: validscan_count, 6: meanFD, 7: site]

    flag = [0] * (sum(count))
    TR = data[4]
    validscan = data[5]

    for i, TR in enumerate(TR):
        volumes = valid_scantime / TR
        if validscan[i] >= volumes:
            flag[i] = 1

    less_than_valid_scantime_subject_id = []
    # with open(output_file, "w") as f:
    for i, subjects in enumerate(flag):
        if flag[i] == 0:
            # f.write("%s\n" % (i+1))
            less_than_valid_scantime_subject_id.append(i+1)

    less_than_valid_scantime_asd_count = count[0] - sum(
        flag[0:count[0]])
    less_than_valid_scantime_con_count = count[1] - \
        sum(flag[count[0]:sum(count)])

    return [less_than_valid_scantime_asd_count, less_than_valid_scantime_con_count, less_than_valid_scantime_subject_id]


def compare(subjects_count, data):
    # subject_count = [subjects_with_asd_count, subjects_in_control_group_count]

    [stat, pvalue_asd] = stats.shapiro(data[0:subjects_count[0]])
    [stat, pvalue_con] = stats.shapiro(
        data[subjects_count[0]: sum(subjects_count)])

    if pvalue_asd or pvalue_con <= 0.05:  # Data is not normally distributed
        [stat, pvalue] = stats.mannwhitneyu(
            data[0:subjects_count[0]], data[subjects_count[0]: sum(subjects_count)])
    else:
        print("Error in compare function!")

    asd_avg = np.nanmean(data[0:subjects_count[0]])
    con_avg = np.nanmean(data[subjects_count[0]: sum(subjects_count)])

    asd_std = np.nanstd(data[0:subjects_count[0]])
    con_std = np.nanstd(data[subjects_count[0]: sum(subjects_count)])

    return [pvalue, asd_avg, asd_std, con_avg, con_std]


def remove(subjects_id_to_be_removed, from_these_lists):
    for subject in sorted(subjects_id_to_be_removed, reverse=True):
        for the_list in from_these_lists:
            del the_list[subject]


def significantDifference(subjects_count_to_be_compared, from_these_lists):
    # Checks if groups are significantly different regarding meanFD and demographic info
    # The return list is respectively corresponding to: [age, fIQ, vIQ, pIQ, mean_FD]
    pvalue, asd_avg, asd_std, con_avg, con_std = ([] for i in range(5))

    for the_list in from_these_lists:
        [a, b, c, d, e] = compare(subjects_count_to_be_compared, the_list)
        pvalue.append(a)
        asd_avg.append(b)
        asd_std.append(c)
        con_avg.append(d)
        con_std.append(e)
    return [pvalue, asd_avg, asd_std, con_avg, con_std]

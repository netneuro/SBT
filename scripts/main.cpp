//
//  main.cpp
//  nullModel
//
//  Created on 6/24/20.
//  Shuffles a given network while conserving it's topology. Then, reports
//  whether each triad/quad is over/under presented.

#include <math.h>
#include <stdlib.h>
#include <time.h>

#include <chrono>
#include <eigen-3.3.9/Eigen/Dense>
#include <fstream>
#include <iostream>
#include <numeric>
#include <string>
#include <vector>

using namespace std;
using namespace Eigen;

struct network {
  MatrixXd data;           // Weighted network.
  MatrixXd binary;         // Binary network.
  Index size;              // Size of the network.
  int nNeg, nPos;          // Pairs.
  int A, B, C, D, total3;  // Triads |A: + + - |B: - - - |C: + + + |D: + - - |
  double p_A, p_B, p_C, p_D;                   // Probability of each triad.
  int type_0, type_1, type_2, type_3, type_4;  // Quads  |type_0:
  FILE *frequencyTriads, *frequencyQuads;      // Pointers to output files.
};

struct surprise {
  double A, B, C,
      D;  // Surprise as defined by Lescovec 2010, for each type of triad.
};

struct groupLevel {  // Just for the final averaging acorss all participants
                     // within each group.
  vector<int> net_nNeg, net_nPos, net_A, net_B, net_C, net_D, shuffle_A,
      shuffle_B, shuffle_C, shuffle_D;
  vector<double> net_pA, net_pB, net_pC, net_pD, shuffle_pA, shuffle_pB,
      shuffle_pC, shuffle_pD, surprise_A, surprise_B, surprise_C, surprise_D;
};

#define MAXBUFSIZE ((int)1e6)
MatrixXd readMatrix(string const &fileName, bool &flag) {
  int cols = 0, rows = 0;
  double buff[MAXBUFSIZE];
  ifstream infile;
  infile.open(fileName);
  if (infile) {
    while (!infile.eof()) {
      string line;
      getline(infile, line);
      int temp_cols = 0;
      stringstream stream(line);
      while (!stream.eof()) stream >> buff[cols * rows + temp_cols++];
      if (temp_cols == 0) continue;
      if (cols == 0) cols = temp_cols;
      rows++;
    }
    infile.close();
    rows--;
    // Populate matrix with numbers.
    MatrixXd result(rows, cols);
    for (int i = 0; i < rows; i++)
      for (int j = 0; j < cols; j++) result(i, j) = buff[cols * i + j];
    return result;
  } else {
    MatrixXd results = MatrixXd::Identity(4, 4);
    cout << fileName + " does not exist. :( \n";
    flag = false;
    return results;
  }
}

void writeMatrix(MatrixXd matrix, string const fileName) {
  const static IOFormat TXTFormat(StreamPrecision, DontAlignCols, ", ", "\n");
  ofstream file(fileName.c_str());
  file << matrix.format(TXTFormat);
}

void countPairs(network &matrix) {
  matrix.nNeg =
      (-1 * (matrix.binary.array() < 0).select(matrix.binary, 0).sum()) / 2;
  matrix.nPos =
      ((matrix.binary.array() > 0).select(matrix.binary, 0).sum()) / 2;
}

void countTriads(network &matrix) {
  for (int i = 0; i < matrix.size - 2; i++) {
    for (int j = i + 1; j < matrix.size - 1; j++) {
      for (int k = j + 1; k < matrix.size; k++) {
        if ((matrix.binary(i, j) != 0) && (matrix.binary(j, k) != 0) &&
            (matrix.binary(k, i) != 0)) {
          matrix.total3 += 1;
          int sum =
              matrix.binary(i, j) + matrix.binary(j, k) + matrix.binary(k, i);
          switch (sum) {
            case +1:
              matrix.A += 1;
              break;
            case -3:
              matrix.B += 1;
              break;
            case +3:
              matrix.C += 1;
              break;
            case -1:
              matrix.D += 1;
              break;
          }
        }
      }
    }
  }
  matrix.p_A = matrix.A / double(matrix.total3);
  matrix.p_B = matrix.B / double(matrix.total3);
  matrix.p_C = matrix.C / double(matrix.total3);
  matrix.p_D = matrix.D / double(matrix.total3);
}

void countQuads(network &matrix) {}

void binarize(network &matrix) {
  MatrixXd neg = (matrix.data.array() < 0).cast<double>();
  MatrixXd pos = (matrix.data.array() > 0).cast<double>();
  matrix.binary = (-neg) + pos;
}

void newRandomCell(network &matrix, MatrixXd &chosenCells, int &random_row,
                   int &random_col) {
  while (true) {
    random_row = rand() % matrix.size;
    random_col = rand() % matrix.size;

    if (random_row > random_col)  // Upper triangle only.
      swap(random_row, random_col);

    // if (seenCells == 0: this random cell has not been chosen before) and (G
    // != 0: there is a link).
    if (!(chosenCells(random_row, random_col)) &&
        (matrix.binary(random_row, random_col) != 0))
      break;
  }
}

void copyUpperToLower(network &matrix) {
  for (int i = 0; i < matrix.size - 1; i++) {
    for (int j = i + 1; j < matrix.size; j++) {
      if (matrix.binary(i, j) != 0) {
        matrix.binary(j, i) = matrix.binary(i, j);
        matrix.data(j, i) = matrix.data(i, j);
      }
    }
  }
}

void shufflize(network &original_matrix, network &shuffled_matrix) {
  MatrixXd chosenCells(original_matrix.size, original_matrix.size);
  chosenCells.setZero();

  shuffled_matrix.data = original_matrix.binary.array().abs();

  int counter = 0;
  countPairs(original_matrix);

  while (counter < original_matrix.nNeg) {
    int random_row = 0, random_col = 0;
    newRandomCell(original_matrix, chosenCells, random_row, random_col);

    float r = ((float)rand() / (RAND_MAX));
    if (r < 0.5) {
      shuffled_matrix.data(random_row, random_col) = -1;
      chosenCells(random_row, random_col) = 1;
      counter += 1;
    }
  }

  binarize(shuffled_matrix);
  copyUpperToLower(shuffled_matrix);
  countPairs(shuffled_matrix);

  if (original_matrix.nNeg == shuffled_matrix.nNeg)
    cout << "You Rock Girl! Number of negative links have not changed after "
            "shuffling. \n";
}

void Leskovec(int i, network &original_matrix, network &shuffled_matrix,
              surprise &surprise, groupLevel &group, FILE *freqReport) {
  double E_A = shuffled_matrix.p_A * original_matrix.total3;
  double E_B = shuffled_matrix.p_B * original_matrix.total3;
  double E_C = shuffled_matrix.p_C * original_matrix.total3;
  double E_D = shuffled_matrix.p_D * original_matrix.total3;

  surprise.A = (original_matrix.A - E_A) /
               double(sqrt(original_matrix.total3 * shuffled_matrix.p_A *
                           (1 - shuffled_matrix.p_A)));
  surprise.B = (original_matrix.B - E_B) /
               double(sqrt(original_matrix.total3 * shuffled_matrix.p_B *
                           (1 - shuffled_matrix.p_B)));
  surprise.C = (original_matrix.C - E_C) /
               double(sqrt(original_matrix.total3 * shuffled_matrix.p_C *
                           (1 - shuffled_matrix.p_C)));
  surprise.D = (original_matrix.D - E_D) /
               double(sqrt(original_matrix.total3 * shuffled_matrix.p_D *
                           (1 - shuffled_matrix.p_D)));

  group.net_nNeg.push_back(original_matrix.nNeg);
  group.net_nPos.push_back(original_matrix.nPos);

  group.net_A.push_back(original_matrix.A);
  group.net_B.push_back(original_matrix.B);
  group.net_C.push_back(original_matrix.C);
  group.net_D.push_back(original_matrix.D);

  group.net_pA.push_back(original_matrix.p_A);
  group.net_pB.push_back(original_matrix.p_B);
  group.net_pC.push_back(original_matrix.p_C);
  group.net_pD.push_back(original_matrix.p_D);

  group.shuffle_A.push_back(shuffled_matrix.A);
  group.shuffle_B.push_back(shuffled_matrix.B);
  group.shuffle_C.push_back(shuffled_matrix.C);
  group.shuffle_D.push_back(shuffled_matrix.D);

  group.shuffle_pA.push_back(shuffled_matrix.p_A);
  group.shuffle_pB.push_back(shuffled_matrix.p_B);
  group.shuffle_pC.push_back(shuffled_matrix.p_C);
  group.shuffle_pD.push_back(shuffled_matrix.p_D);

  group.surprise_A.push_back(surprise.A);
  group.surprise_B.push_back(surprise.B);
  group.surprise_C.push_back(surprise.C);
  group.surprise_D.push_back(surprise.D);

  fprintf(freqReport, "%d\t", i);

  if (original_matrix.A < shuffled_matrix.A)
    fprintf(freqReport, "A: Under Represented \t");
  else
    fprintf(freqReport, "A: Over Represented  \t");

  if (original_matrix.B < shuffled_matrix.B)
    fprintf(freqReport, "B: Under Represented \t");
  else
    fprintf(freqReport, "B: Over Represented  \t");

  if (original_matrix.C < shuffled_matrix.C)
    fprintf(freqReport, "C: Under Represented \t");
  else
    fprintf(freqReport, "C: Over Represented  \t");

  if (original_matrix.D < shuffled_matrix.D)
    fprintf(freqReport, "D: Under Represented \n");
  else
    fprintf(freqReport, "D: Over Represented  \n");
}

void averageResults(groupLevel &group, FILE *averageReport) {
  float average_netnNeg =
      accumulate(group.net_nNeg.begin(), group.net_nNeg.end(), 0.0) /
      group.net_nNeg.size();
  float average_netnPos =
      accumulate(group.net_nPos.begin(), group.net_nPos.end(), 0.0) /
      group.net_nPos.size();
  float average_netA = accumulate(group.net_A.begin(), group.net_A.end(), 0.0) /
                       group.net_A.size();
  float average_netB = accumulate(group.net_B.begin(), group.net_B.end(), 0.0) /
                       group.net_B.size();
  float average_netC = accumulate(group.net_C.begin(), group.net_C.end(), 0.0) /
                       group.net_C.size();
  float average_netD = accumulate(group.net_D.begin(), group.net_D.end(), 0.0) /
                       group.net_D.size();
  float average_net_pA =
      accumulate(group.net_pA.begin(), group.net_pA.end(), 0.0) /
      group.net_pA.size();
  float average_net_pB =
      accumulate(group.net_pB.begin(), group.net_pB.end(), 0.0) /
      group.net_pB.size();
  float average_net_pC =
      accumulate(group.net_pC.begin(), group.net_pC.end(), 0.0) /
      group.net_pC.size();
  float average_net_pD =
      accumulate(group.net_pD.begin(), group.net_pD.end(), 0.0) /
      group.net_pD.size();
  float average_shuffle_pA =
      accumulate(group.shuffle_pA.begin(), group.shuffle_pA.end(), 0.0) /
      group.shuffle_pA.size();
  float average_shuffle_pB =
      accumulate(group.shuffle_pB.begin(), group.shuffle_pB.end(), 0.0) /
      group.shuffle_pB.size();
  float average_shuffle_pC =
      accumulate(group.shuffle_pC.begin(), group.shuffle_pC.end(), 0.0) /
      group.shuffle_pC.size();
  float average_shuffle_pD =
      accumulate(group.shuffle_pD.begin(), group.shuffle_pD.end(), 0.0) /
      group.shuffle_pD.size();
  float average_surprise_A =
      accumulate(group.surprise_A.begin(), group.surprise_A.end(), 0.0) /
      group.surprise_A.size();
  float average_surprise_B =
      accumulate(group.surprise_B.begin(), group.surprise_B.end(), 0.0) /
      group.surprise_B.size();
  float average_surprise_C =
      accumulate(group.surprise_C.begin(), group.surprise_C.end(), 0.0) /
      group.surprise_C.size();
  float average_surprise_D =
      accumulate(group.surprise_D.begin(), group.surprise_D.end(), 0.0) /
      group.surprise_D.size();

  fprintf(averageReport,
          "A:        %.2f\t %.2f\t %.2f\t %.3f\t\t %.3f\t\t %+.2f\t \n",
          average_netnNeg, average_netnPos, average_netA, average_net_pA,
          average_shuffle_pA, average_surprise_A);
  fprintf(averageReport,
          "B:        %.2f\t %.2f\t %.2f\t %.3f\t\t %.3f\t\t %+.2f\t \n",
          average_netnNeg, average_netnPos, average_netB, average_net_pB,
          average_shuffle_pB, average_surprise_B);
  fprintf(averageReport,
          "C:        %.2f\t %.2f\t %.2f\t %.3f\t\t %.3f\t\t %+.2f\t \n",
          average_netnNeg, average_netnPos, average_netC, average_net_pC,
          average_shuffle_pC, average_surprise_C);
  fprintf(averageReport,
          "D:        %.2f\t %.2f\t %.2f\t %.3f\t\t %.3f\t\t %+.2f\t \n",
          average_netnNeg, average_netnPos, average_netD, average_net_pD,
          average_shuffle_pD, average_surprise_D);
}

int main(int argc, const char *argv[]) {
  int size = 400, participants = 40;
  char inFileName[40], outFileName[40];
  MatrixXd data(size, size), binary(size, size);
  groupLevel group;
  FILE *netFreqTriads, *netFreqQuads, *shuffledFreqTriads, *shuffledFreqQuads,
      *freqReport, *surpriseReport, *averageReport;

  freqReport = fopen("freqReport.txt", "w");
  surpriseReport = fopen("surpriseReport.txt", "w");
  averageReport = fopen("averageReport.txt", "w");
  netFreqTriads = fopen("netFreqTriads.txt", "w");
  shuffledFreqTriads = fopen("shuffledFreqTriads.txt", "w");
  netFreqQuads = fopen("netFreqQuads.txt", "w");
  shuffledFreqQuads = fopen("shuffledFreqQuads.txt", "w");

  fprintf(
      netFreqTriads,
      "i\t nNeg\t nPos\t A\t B\t C\t D\t P(A)\t\t P(B)\t\t P(C)\t\t P(D)\n\n");
  fprintf(
      shuffledFreqTriads,
      "i\t nNeg\t nPos\t A\t B\t C\t D\t P(A)\t\t P(B)\t\t P(C)\t\t P(D)\n\n");
  fprintf(averageReport,
          "Type\t |nNeg|\t\t |NPos|\t\t |T_i|\t\t p(T_i)\t\t po(T_i)\t "
          "s(T_i)\t\t \n\n");
  fprintf(surpriseReport, "i\t S(A)\t\t S(B)\t\t S(C)\t\t S(D)\n\n");

  for (int i = 1; i <= participants; i++) {
    auto start = std::chrono::high_resolution_clock::now();

    network net = {data,        binary, size, 0, 0, 0, 0, 0, 0, 0,
                   0,           0,      0,    0, 0, 0, 0, 0, 0, netFreqTriads,
                   netFreqQuads};
    network shuffled = {data,
                        binary,
                        size,
                        0,
                        0,
                        0,
                        0,
                        0,
                        0,
                        0,
                        0,
                        0,
                        0,
                        0,
                        0,
                        0,
                        0,
                        0,
                        0,
                        shuffledFreqTriads,
                        shuffledFreqQuads};
    surprise surprise = {0, 0, 0, 0};
    bool flag = true;

    cout << i << "\n";
    sprintf(inFileName, "corr_harmonized_adult_%03d.txt", i + 40);
    sprintf(outFileName, "shuffledMaskedCorr_%03d.txt", i);

    //        Simple matrix for testing:
    //        net.data(0,0) = 0; net.data(0,1)=1; net.data(0,2)=1;
    //        net.data(0,3)=1; net.data(1,0) = 1; net.data(1,1)=0;
    //        net.data(1,2)=-1; net.data(1,3)= 0; net.data(2,0) = 1;
    //        net.data(2,1)=-1; net.data(2,2)=0; net.data(2,3)=-1; net.data(3,0)
    //        = 1; net.data(3,1)=0; net.data(3,2)=-1; net.data(3,3)=0; cout <<
    //        "matrix :" << net.data << "\n";

    net.data = readMatrix(inFileName, flag);
    binarize(net);

    if (flag) {
      countTriads(net);
      shufflize(net, shuffled);
      countTriads(shuffled);
      Leskovec(i, net, shuffled, surprise, group, freqReport);
      // writeMatrix    (shuffled.data, outFileName);
      fprintf(surpriseReport, "%d\t %+.2f\t %+.2f\t\t %+.2f\t %+.2f\n", i,
              surprise.A, surprise.B, surprise.C, surprise.D);
      fprintf(netFreqTriads,
              "%d\t %d\t %d\t %d\t %d\t %d\t %d\t %f\t %f\t %f\t %f\n", i,
              net.nNeg, net.nPos, net.A, net.B, net.C, net.D, net.p_A, net.p_B,
              net.p_C, net.p_D);
      fprintf(shuffledFreqTriads,
              "%d\t %d\t %d\t %d\t %d\t %d\t %d\t %f\t %f\t %f\t %f\t \n", i,
              shuffled.nNeg, shuffled.nPos, shuffled.A, shuffled.B, shuffled.C,
              shuffled.D, shuffled.p_A, shuffled.p_B, shuffled.p_C,
              shuffled.p_D);
    }
    auto finish = std::chrono::high_resolution_clock::now();
    std::chrono::duration<double> elapsed = finish - start;
    cout << "Elapsed time           : " << elapsed.count() << " s\n\n";
  }
  averageResults(group, averageReport);
  fclose(freqReport);
  fclose(netFreqTriads);
  fclose(shuffledFreqTriads);
  fclose(netFreqQuads);
  fclose(shuffledFreqQuads);
  fclose(averageReport);
  fclose(surpriseReport);
  cout << "AND... CHECKMATE B-) \n\n";
  return 0;
}

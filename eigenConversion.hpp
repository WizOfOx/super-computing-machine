#include "MatlabDataArray.hpp"
#include <Eigen/Dense>

Eigen::MatrixXd convert(const matlab::data::Array& x);
matlab::data::TypedArray<double> convert(matlab::data::ArrayFactory& factory, const Eigen::MatrixXd& x);

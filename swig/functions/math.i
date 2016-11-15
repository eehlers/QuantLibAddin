
%group(Math);

%insert(obj_hpp) %{
#include <ql/math/matrixutilities/symmetricschurdecomposition.hpp>
#include <ql/math/matrixutilities/getcovariance.hpp>
%}

%insert(obj_cpp) %{
#include <ql/math/primenumbers.hpp>
#include <ql/math/matrixutilities/choleskydecomposition.hpp>
%}

namespace QuantLib {

    %noctor(PrimeNumbers);
    class PrimeNumbers {
      public:

        //! Returns the N-th prime number.
        %rename2(get, PrimeNumber);
        static BigNatural get(Size absoluteIndex);
    };

    //! Returns the Cholesky decomposition of a real symmetric matrix.
    const Disposable<Matrix> CholeskyDecomposition(
        const Matrix& Matrix,                       //!< Symmetric matrix (hopefully positive semi-definite at least).
        bool Flexible = false                       //!< If TRUE it returns a result also for positive semi-definite matrix.
    );

    //! Returns the pseudo square root of a real symmetric matrix.
    const Disposable<Matrix> pseudoSqrt(
        const Matrix &Matrix,                       //!< Symmetric matrix (hopefully positive semi-definite at least).
        SalvagingAlgorithm::Type SalvagingAlgorithm = SalvagingAlgorithm::None  //!< Salvaging algorithm for symmetric matrix not positive semi-definite (None, Spectral).
    );

    //! Returns the rank reduced pseudo square root of a real symmetric matrix.
    const Disposable<Matrix> rankReducedSqrt(
        const Matrix& Matrix,                       //!< Symmetric matrix (hopefully positive semi-definite at least).
        Size MaxRank,                               //!< Number of principal components retained, i.e. max rank for the result matrix.
        Real ComponentPercentage,                   //!< Principal components retained as percentage of eigenvalues' sum.
        SalvagingAlgorithm::Type SalvagingAlgorithm //!< Salvaging algorithm for symmetric matrix not positive semi-definite (None, Spectral).
    );

    class SymmetricSchurDecomposition {
      public:
        SymmetricSchurDecomposition(
            const Matrix &SymmetricMatrix           //!< Symmetrix matrix to be decomposed.
        );

        //! Returns the eigenvalues for the given SymmetricSchurDecomposition object.
        const Array& eigenvalues() const;

        //! Returns the eigenvectors  for the given SymmetricSchurDecomposition object. Eigenvectors are returned columnwise.
        const Matrix& eigenvectors() const;
    };

    class CovarianceDecomposition {
      public:

        //! 
        CovarianceDecomposition(
            const Matrix& SymmetricMatrix,          //!< Symmetrix covariance matrix to be decomposed.
            Real Tolerance = 1.0e-12);              //!< Numerical tolerance for non symmetric matrix.

        //! Returns the variance vector for the given CovarianceDecomposition object.
        const Array& variances() const;

        //! Returns the standard deviation (i.e. volatility times square root of time) vector for the given CovarianceDecomposition object.
        const Array& standardDeviations() const;

        //! Returns the correlation matrix for the given CovarianceDecomposition object.
        const Matrix& correlationMatrix() const;
    };
}

namespace QuantLibAddin {

    //! Returns the normal cumulative distribution for the specified mean and standard deviation.
    double normDist(
        double X,                                   //!< Is the value for which you want the distribution.
        double Mean=0.0,                            //!< Is the arithmetic mean of the distribution.
        double Standard_dev=1.0,                    //!< Is the standard deviation of the distribution, a positive number.
        bool Cumulative=true                        //!< Is a logical value: for the cumulative distribution function, use TRUE; for the probability mass function, use FALSE.
    );

    //! Returns the standard normal cumulative distribution (has a mean of zero and standard deviation of one).
    double normSDist(
        double Z                                    //!< Is the value for which you want the distribution.
    );

    //! Returns the inverse of the normal cumulative distribution for the specified mean and standard deviation.
    double normInv(
        double Probability,                         //!< Is a probability corresponding to the normal distribution, a number between 0 and 1 inclusive.
        double Mean=0.0,                            //!< Is the arithmetic mean of the distribution.
        double Standard_dev=1.0                     //!< Is the standard deviation of the distribution, a positive number.
    );

    //! Returns the inverse of the standard normal cumulative distribution (has a mean of zero and standard deviation of one).
    double normSInv(
        double Probability                          //!< Is a probability corresponding to the normal distribution, a number between 0 and 1 inclusive.
    );

    //! Returns the covariance matrix generated using the correlation matrix and the standard deviation (i.e. volatility times square root of time) array.
    QuantLib::Matrix getCovariance(
        std::vector<double> Vols,                   //!< Volatility vector.
        const QuantLib::Matrix& Matrix,             //!< Symmetric matrix (hopefully positive semi-definite at least).
        double Tolerance=1.0e12                     //!< Numerical tolerance for non symmetric matrix.
    );
}

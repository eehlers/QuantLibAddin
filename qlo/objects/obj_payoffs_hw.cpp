
// BEGIN buffer b_lib_grp_cpp


#include <qlo/objects/obj_payoffs.hpp>
#include <qlo/enumerations/factories/payoffsfactory.hpp>

QuantLibAddin::StrikedTypePayoff::StrikedTypePayoff(
        const boost::shared_ptr<reposit::ValueObject>& properties,
        const std::string& payoffID,
        const QuantLib::Option::Type& optionType,
        const QuantLib::Real strike,
        const QuantLib::Real thirdParameter,
        bool permanent) : TypePayoff(properties, permanent) {
    if (thirdParameter==QuantLib::Null<QuantLib::Real>())
        libraryObject_ = reposit::Create<boost::shared_ptr<QuantLib::Payoff> >()(
            payoffID, optionType, strike);
    else
        libraryObject_ = reposit::Create<boost::shared_ptr<QuantLib::Payoff> >()(
            payoffID, optionType, strike, thirdParameter);
}

//QuantLib::Real QuantLibAddin::StrikedTypePayoff::strike() const {
//    boost::shared_ptr<QuantLib::StrikedTypePayoff> x =
//        boost::dynamic_pointer_cast<QuantLib::StrikedTypePayoff>(libraryObject_);
//    return x->strike();
//}

QuantLib::Real QuantLibAddin::StrikedTypePayoff::thirdParameter() const {
    return 0.;
}

using CSV, DataFrames
using TextAnalysis: NaiveBayesClassifier, fit!, predict

spamdata = DataFrame(CSV.read("/Users/kimfung/Documents/Julia/TextAnalysis/spam.csv"; allowmissing=:none))
global m = NaiveBayesClassifier([:ham, :spam])
for row in eachrow(spamdata)
    if row.v1 == "ham"
        fit!(m, filter(isvalid, row.v2), :ham)
    elseif row.v1 == "spam"
        fit!(m, filter(isvalid, row.v2), :spam)
    end
end

function checkspam(msg::String)
    prediction = predict(m, msg)
    if prediction[:spam] > prediction[:ham]
        println("spam")
    else
        println("ham (not spam)")
    end
end

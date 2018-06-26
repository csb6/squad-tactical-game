class Labeller
    def updateLabels
        puts "Name"
    end
end

class WordyLabeller < Labeller
    def updateLabels
        super
        puts "Age"
        puts "Weight"
    end
end

labeller = Labeller.new
wordy = WordyLabeller.new

labeller.updateLabels
wordy.updateLabels
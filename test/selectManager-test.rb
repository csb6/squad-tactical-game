require 'tk'
require_relative '../lib/engine/SelectionManager'

selectManager = SelectionManager.instance

class Soldier
    def initialize(selectManager)
        @selectManager = selectManager
    end

    def getSM
        puts "#{@selectManager.inMovingMode}"
    end
end

soldier = Soldier.new(selectManager)

selectManager.inMovingMode = true
puts soldier.getSM
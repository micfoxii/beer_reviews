class BeerReviews::Beer 
    attr_accessor :name, :type, :brewery
    def self.all
        puts <<-DOC.gsub /^\s*/, ''
            1. Jammer - Sixpoint Brewery - Gose
            2. Higher Burnin IPA - LIC Beer Project - American IPA
            3. Better Selves - Able Seedhouse and Brewery - Specialty IPA
        DOC

        beer_1 = self.new
        beer_1.name = "Jammer"
        beer_1.type = "Gose"
        beer_1.brewery = "Sixpoint Brewery"

        beer_2 = self.new
        beer_2.name = "Higher Burnin IPA"
        beer_2.type = "American IPA"
        beer_2.brewery = "LIC Beer Project"

        beer_3 = self.new
        beer_3.name = "Better Selves"
        beer_3.type = "Specialty IPA"
        beer_3.brewery = "Able Seedhouse and Brewery"

        [beer_1, beer_2, beer_3]
    end

        
end
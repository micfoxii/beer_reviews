class BeerReviews::CLI
    attr_accessor :name, :style, :brewery
    
    def call
        #loading
        BeerReviews::Scraper.scrape_beers #FOR ORGINAL PART LISTING BEERS
        start
    end
        
    def start

        list_beers
        user_selects_beer
        menu_or_exit

    end 

    def list_beers
        puts " Beer Advocate's Top 25 Beers "
        BeerReviews::Beers.all.each.with_index(1) do |beer, index|
            puts "#{index}. #{beer.name} - #{beer.style}"
            puts "     #{beer.brewery}"
        end
    end

    def user_selects_beer

        puts "\nPlease enter the number of the beer you would like to learn more about!"
        puts ""
        
        input = gets.strip

        if input.to_i.between?(1,25)
            beer = BeerReviews::Beers.find(input.to_i)
            list_beer_details(beer)
        else
            puts "\nPlease select a valid number from list!"
            puts ""
            sleep(3)
            list_beers
            user_selects_beer
        end
    end

    def menu_or_exit
        puts "\nWould you like to learn about another beer? Please type list to return to list, or exit to leave."
        input = gets.strip.downcase

        if input == "list"
            start
        elsif input.strip.downcase == "exit"
            goodbye
        else
            puts "\nSorry, I do not understand."
            menu_or_exit
        end
    end

    def list_beer_details(beer)
        BeerReviews::Scraper.scrape_beer_details(beer)
        puts "\n#{beer.name} - #{beer.style}"
        puts "#{beer.brewery}" 
        puts "NOTES: #{beer.description}" #blocking url scrape, sending back to top 250 list
        puts "To read more reviews, please follow link below:"
        puts "   #{beer.url}" #starts opening beer link, but then redirects to top 250 list
    end

    def goodbye
        puts "\nSee you next time and remember to drink responsibly!"
    end

    def loading 
        spinner = Enumerator.new do |e|
            loop do
                e.yield '|'
                e.yield '/'
                e.yield '-'
                e.yield '\\'
            end
        end

        1.upto(100) do |i|
            progress = "=" * (i/5) unless i < 5
            printf("\rRetrieving Beer List: [%-20s] %d%% %s", progress, i , spinner.next)
            sleep(0.1)
        end
    end

end
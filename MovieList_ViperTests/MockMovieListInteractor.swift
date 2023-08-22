//
//  MockMovieListInteractor.swift
//  MovieList_ViperTests
//
//  Created by Sezgin Çiftci on 22.08.2023.
//

import Foundation

final class MockMovieListInteractor: MovieListInteractorProtocol {

    var invokedPresenterSetter = false
    var invokedPresenterSetterCount = 0
    var invokedPresenter: MovieListInteractorOutputProtocol?
    var invokedPresenterList = [MovieListInteractorOutputProtocol?]()
    var invokedPresenterGetter = false
    var invokedPresenterGetterCount = 0
    var stubbedPresenter: MovieListInteractorOutputProtocol!

    var presenter: MovieListInteractorOutputProtocol? {
        set {
            invokedPresenterSetter = true
            invokedPresenterSetterCount += 1
            invokedPresenter = newValue
            invokedPresenterList.append(newValue)
        }
        get {
            invokedPresenterGetter = true
            invokedPresenterGetterCount += 1
            return stubbedPresenter
        }
    }

    var invokedFetchMainPageMovies = false
    var invokedFetchMainPageMoviesCount = 0

    func fetchMainPageMovies() {
        invokedFetchMainPageMovies = true
        invokedFetchMainPageMoviesCount += 1
        invokedPresenter?.didFetchTrendingMoviesSucces(movie: getDummyMovieList())
        invokedPresenter?.didFetchPopularMoviesSucces(movie: getDummyMovieList())
        invokedPresenter?.didFetchUpcomingMoviesSucces(movie: getDummyMovieList())
        invokedPresenter?.didFetchRecommendationMoviesSucces(movie: getDummyMovieList())
    }

    var invokedSaveSeenMovie = false
    var invokedSaveSeenMovieCount = 0
    var invokedSaveSeenMovieParameters: (movieId: Int, Void)?
    var invokedSaveSeenMovieParametersList = [(movieId: Int, Void)]()

    func saveSeenMovie(movieId: Int) {
        invokedSaveSeenMovie = true
        invokedSaveSeenMovieCount += 1
        invokedSaveSeenMovieParameters = (movieId, ())
        invokedSaveSeenMovieParametersList.append((movieId, ()))
    }
    
    
    
}

extension MockMovieListInteractor {
    func getDummyMovieList() -> MovieListModel? {
        let dummyResult = try? JSONDecoder().decode(MovieListModel.self, from: MockMovieListInteractor.jsonData)
        if let dummyResult {
            return dummyResult
        }
        return nil
    }
    
    static let jsonData = """
        {
          "page": 1,
          "results": [
            {
              "adult": false,
              "backdrop_path": "/2D6ksPSChcRcZuvavrae9g4b8oh.jpg",
              "id": 832502,
              "title": "The Monkey King",
              "original_language": "en",
              "original_title": "The Monkey King",
              "overview": "A stick-wielding monkey teams with a young girl on an epic quest for immortality, battling demons, dragons, gods — and his own ego — along the way.",
              "poster_path": "/i6ye8ueFhVE5pXatgyRrZ83LBD8.jpg",
              "media_type": "movie",
              "genre_ids": [
                16,
                14,
                12,
                10751,
                35
              ],
              "popularity": 101.914,
              "release_date": "2023-08-11",
              "video": false,
              "vote_average": 7.024,
              "vote_count": 42
            },
            {
              "adult": false,
              "backdrop_path": "/H6j5smdpRqP9a8UnhWp6zfl0SC.jpg",
              "id": 565770,
              "title": "Blue Beetle",
              "original_language": "en",
              "original_title": "Blue Beetle",
              "overview": "Recent college grad Jaime Reyes returns home full of aspirations for his future, only to find that home is not quite as he left it. As he searches to find his purpose in the world, fate intervenes when Jaime unexpectedly finds himself in possession of an ancient relic of alien biotechnology: the Scarab.",
              "poster_path": "/lZ2sOCMCcGaPppaXj0Wiv0S7A08.jpg",
              "media_type": "movie",
              "genre_ids": [
                28,
                878
              ],
              "popularity": 948.321,
              "release_date": "2023-08-16",
              "video": false,
              "vote_average": 6.903,
              "vote_count": 175
            },
            {
              "adult": false,
              "backdrop_path": "/jZIYaISP3GBSrVOPfrp98AMa8Ng.jpg",
              "id": 976573,
              "title": "Elemental",
              "original_language": "en",
              "original_title": "Elemental",
              "overview": "In a city where fire, water, land and air residents live together, a fiery young woman and a go-with-the-flow guy will discover something elemental: how much they have in common.",
              "poster_path": "/6oH378KUfCEitzJkm07r97L0RsZ.jpg",
              "media_type": "movie",
              "genre_ids": [
                16,
                35,
                10751,
                14,
                10749
              ],
              "popularity": 4863.437,
              "release_date": "2023-06-14",
              "video": false,
              "vote_average": 7.75,
              "vote_count": 1257
            },
            {
              "adult": false,
              "backdrop_path": "/4HodYYKEIsGOdinkGi2Ucz6X9i0.jpg",
              "id": 569094,
              "title": "Spider-Man: Across the Spider-Verse",
              "original_language": "en",
              "original_title": "Spider-Man: Across the Spider-Verse",
              "overview": "After reuniting with Gwen Stacy, Brooklyn’s full-time, friendly neighborhood Spider-Man is catapulted across the Multiverse, where he encounters the Spider Society, a team of Spider-People charged with protecting the Multiverse’s very existence. But when the heroes clash on how to handle a new threat, Miles finds himself pitted against the other Spiders and must set out on his own to save those he loves most.",
              "poster_path": "/8Vt6mWEReuy4Of61Lnj5Xj704m8.jpg",
              "media_type": "movie",
              "genre_ids": [
                16,
                28,
                12
              ],
              "popularity": 2374.865,
              "release_date": "2023-05-31",
              "video": false,
              "vote_average": 8.457,
              "vote_count": 3652
            },
            {
              "adult": false,
              "backdrop_path": "/rLb2cwF3Pazuxaj0sRXQ037tGI1.jpg",
              "id": 872585,
              "title": "Oppenheimer",
              "original_language": "en",
              "original_title": "Oppenheimer",
              "overview": "The story of J. Robert Oppenheimer’s role in the development of the atomic bomb during World War II.",
              "poster_path": "/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg",
              "media_type": "movie",
              "genre_ids": [
                18,
                36
              ],
              "popularity": 761.391,
              "release_date": "2023-07-19",
              "video": false,
              "vote_average": 8.262,
              "vote_count": 2123
            },
            {
              "adult": false,
              "backdrop_path": "/m1k24MwmoqAdKMPJDaBLwdB5Tps.jpg",
              "id": 724209,
              "title": "Heart of Stone",
              "original_language": "en",
              "original_title": "Heart of Stone",
              "overview": "An intelligence operative for a shadowy global peacekeeping agency races to stop a hacker from stealing its most valuable — and dangerous — weapon.",
              "poster_path": "/vB8o2p4ETnrfiWEgVxHmHWP9yRl.jpg",
              "media_type": "movie",
              "genre_ids": [
                53,
                28
              ],
              "popularity": 3752.86,
              "release_date": "2023-08-09",
              "video": false,
              "vote_average": 6.943,
              "vote_count": 643
            },
            {
              "adult": false,
              "backdrop_path": "/nHf61UzkfFno5X1ofIhugCPus2R.jpg",
              "id": 346698,
              "title": "Barbie",
              "original_language": "en",
              "original_title": "Barbie",
              "overview": "Barbie and Ken are having the time of their lives in the colorful and seemingly perfect world of Barbie Land. However, when they get a chance to go to the real world, they soon discover the joys and perils of living among humans.",
              "poster_path": "/iuFNMS8U5cb6xfzi51Dbkovj7vM.jpg",
              "media_type": "movie",
              "genre_ids": [
                35,
                12,
                14
              ],
              "popularity": 1860.335,
              "release_date": "2023-07-19",
              "video": false,
              "vote_average": 7.4,
              "vote_count": 3266
            },
            {
              "adult": false,
              "backdrop_path": "/f7UI3dYpr7ZUHGo0iIr1Qvy1VPe.jpg",
              "id": 1040148,
              "title": "Ruby Gillman, Teenage Kraken",
              "original_language": "en",
              "original_title": "Ruby Gillman, Teenage Kraken",
              "overview": "Ruby Gillman, a sweet and awkward high school student, discovers she's a direct descendant of the warrior kraken queens. The kraken are sworn to protect the oceans of the world against the vain, power-hungry mermaids. Destined to inherit the throne from her commanding grandmother, Ruby must use her newfound powers to protect those she loves most.",
              "poster_path": "/kgrLpJcLBbyhWIkK7fx1fM4iSvf.jpg",
              "media_type": "movie",
              "genre_ids": [
                16,
                10751,
                14,
                35
              ],
              "popularity": 832.775,
              "release_date": "2023-06-28",
              "video": false,
              "vote_average": 7.561,
              "vote_count": 565
            },
            {
              "adult": false,
              "backdrop_path": "/9fUu0jwR1V5OJ9M1G4XCDsD4sQz.jpg",
              "id": 666277,
              "title": "Past Lives",
              "original_language": "en",
              "original_title": "Past Lives",
              "overview": "Two childhood friends are separated after one’s family emigrates from South Korea. Two decades later, they are reunited in New York for one week as they confront notions of destiny, love and the choices that make a life.",
              "poster_path": "/gXt3eVpaBq6q9SaLDrgSnzsUyIl.jpg",
              "media_type": "movie",
              "genre_ids": [
                10749,
                18
              ],
              "popularity": 27.401,
              "release_date": "2023-06-02",
              "video": false,
              "vote_average": 7.9,
              "vote_count": 35
            },
            {
              "adult": false,
              "backdrop_path": "/yF1eOkaYvwiORauRCPWznV9xVvi.jpg",
              "id": 298618,
              "title": "The Flash",
              "original_language": "en",
              "original_title": "The Flash",
              "overview": "When his attempt to save his family inadvertently alters the future, Barry Allen becomes trapped in a reality in which General Zod has returned and there are no Super Heroes to turn to. In order to save the world that he is in and return to the future that he knows, Barry's only hope is to race for his life. But will making the ultimate sacrifice be enough to reset the universe?",
              "poster_path": "/rktDFPbfHfUbArZ6OOOKsXcv0Bm.jpg",
              "media_type": "movie",
              "genre_ids": [
                28,
                12,
                878
              ],
              "popularity": 1744.899,
              "release_date": "2023-06-13",
              "video": false,
              "vote_average": 6.973,
              "vote_count": 2422
            },
            {
              "adult": false,
              "backdrop_path": "/8fczVZOBw1wy43z4ukpHxYTFFm1.jpg",
              "id": 1153222,
              "title": "LEGO Disney Princess: The Castle Quest",
              "original_language": "en",
              "original_title": "LEGO Disney Princess: The Castle Quest",
              "overview": "Tiana, Moana, Snow White, Rapunzel, and Ariel are off on an adventure as they are each unexpectedly transported to a mysterious castle. Shortly after arriving, they soon discover that Gaston has hatched an evil plan to take over all their kingdoms! The Princess characters must work together to solve challenges hidden deep within the castle walls and try to save their kingdoms from Gaston. Will bravery, quick-thinking, and teamwork prevail?",
              "poster_path": "/q17tXNROOslj7uCGicKNlIf9Rx6.jpg",
              "media_type": "movie",
              "genre_ids": [
                16
              ],
              "popularity": 159.589,
              "release_date": "2023-08-18",
              "video": false,
              "vote_average": 7.286,
              "vote_count": 7
            },
            {
              "adult": false,
              "backdrop_path": "/rRcNmiH55Tz0ugUsDUGmj8Bsa4V.jpg",
              "id": 884605,
              "title": "No Hard Feelings",
              "original_language": "en",
              "original_title": "No Hard Feelings",
              "overview": "On the brink of losing her childhood home, Maddie discovers an intriguing job listing: wealthy helicopter parents looking for someone to “date” their introverted 19-year-old son, Percy, before he leaves for college. To her surprise, Maddie soon discovers the awkward Percy is no sure thing.",
              "poster_path": "/4K7gQjD19CDEPd7A9KZwr2D9Nco.jpg",
              "media_type": "movie",
              "genre_ids": [
                35,
                10749
              ],
              "popularity": 1591.22,
              "release_date": "2023-06-15",
              "video": false,
              "vote_average": 7.108,
              "vote_count": 780
            },
            {
              "adult": false,
              "backdrop_path": "/5YZbUmjbMa3ClvSW1Wj3D6XGolb.jpg",
              "id": 447365,
              "title": "Guardians of the Galaxy Vol. 3",
              "original_language": "en",
              "original_title": "Guardians of the Galaxy Vol. 3",
              "overview": "Peter Quill, still reeling from the loss of Gamora, must rally his team around him to defend the universe along with protecting one of their own. A mission that, if not completed successfully, could quite possibly lead to the end of the Guardians as we know them.",
              "poster_path": "/r2J02Z2OpNTctfOSN1Ydgii51I3.jpg",
              "media_type": "movie",
              "genre_ids": [
                878,
                12,
                28
              ],
              "popularity": 1007,
              "release_date": "2023-05-03",
              "video": false,
              "vote_average": 8.041,
              "vote_count": 4428
            },
            {
              "adult": false,
              "backdrop_path": "/gRpnYEI4L4uSXSHrFgf42jDeD89.jpg",
              "id": 1151344,
              "title": "The List",
              "original_language": "en",
              "original_title": "The List",
              "overview": "After her fiance sleeps with a celebrity on his free pass list, Abby Meyers, with nothing but five names and a fantasy shared by millions, sets out for Los Angeles to sleep with someone from hers.",
              "poster_path": "/8vfyhKkTwvxbV5UuuIMBP0BLILv.jpg",
              "media_type": "movie",
              "genre_ids": [
                10749,
                35
              ],
              "popularity": 26.68,
              "release_date": "2023-08-21",
              "video": false,
              "vote_average": 6.8,
              "vote_count": 4
            },
            {
              "adult": false,
              "backdrop_path": "/zN41DPmPhwmgJjHwezALdrdvD0h.jpg",
              "id": 615656,
              "title": "Meg 2: The Trench",
              "original_language": "en",
              "original_title": "Meg 2: The Trench",
              "overview": "An exploratory dive into the deepest depths of the ocean of a daring research team spirals into chaos when a malevolent mining operation threatens their mission and forces them into a high-stakes battle for survival.",
              "poster_path": "/4m1Au3YkjqsxF8iwQy0fPYSxE0h.jpg",
              "media_type": "movie",
              "genre_ids": [
                28,
                878,
                27
              ],
              "popularity": 1701.916,
              "release_date": "2023-08-02",
              "video": false,
              "vote_average": 6.924,
              "vote_count": 535
            },
            {
              "adult": false,
              "backdrop_path": "/WyGsyzSwGN4ZY9ZG2SJzGM4UPe.jpg",
              "id": 885331,
              "title": "Gadar 2",
              "original_language": "hi",
              "original_title": "गदर २",
              "overview": "During the Indo-Pakistani War of 1971, Tara Singh returns to Pakistan to bring his son, Charanjeet, back home.",
              "poster_path": "/ipoUI3FzVTczg2r8mYxNlE5SsMh.jpg",
              "media_type": "movie",
              "genre_ids": [
                28,
                18,
                53
              ],
              "popularity": 81.517,
              "release_date": "2023-08-11",
              "video": false,
              "vote_average": 7.2,
              "vote_count": 25
            },
            {
              "adult": false,
              "backdrop_path": "/iElG9sADxQFWCz9ADIMWp70CUJS.jpg",
              "id": 1128604,
              "title": "Snoopy Presents: One-of-a-Kind Marcie",
              "original_language": "en",
              "original_title": "Snoopy Presents: One-of-a-Kind Marcie",
              "overview": "Quiet, kindhearted introvert Marcie has lots of brilliant ideas to help her friends achieve goals and solve problems. But when the world takes notice and the spotlight lands on her, sharing those ideas becomes a challenge.",
              "poster_path": "/lFDPyo6mdooNcHvgy17gz1GEjg4.jpg",
              "media_type": "movie",
              "genre_ids": [
                16,
                10751
              ],
              "popularity": 115.749,
              "release_date": "2023-08-17",
              "video": false,
              "vote_average": 7,
              "vote_count": 8
            },
            {
              "adult": false,
              "backdrop_path": "/7gFEPIcJDQvGq9xTvlPL2ZQB27c.jpg",
              "id": 980489,
              "title": "Gran Turismo",
              "original_language": "en",
              "original_title": "Gran Turismo",
              "overview": "The ultimate wish fulfillment tale of a teenage Gran Turismo player whose gaming skills won him a series of Nissan competitions to become an actual professional racecar driver.",
              "poster_path": "/51tqzRtKMMZEYUpSYkrUE7v9ehm.jpg",
              "media_type": "movie",
              "genre_ids": [
                28,
                18,
                12
              ],
              "popularity": 232.251,
              "release_date": "2023-08-09",
              "video": false,
              "vote_average": 7.237,
              "vote_count": 112
            },
            {
              "adult": false,
              "backdrop_path": "/sil4GzTAvmxFWqsp5FWZcG7adtS.jpg",
              "id": 1074262,
              "title": "10 Days of a Bad Man",
              "original_language": "tr",
              "original_title": "Kötü Adamın 10 Günü",
              "overview": "Battered, broken and bereaved, a private investigator must muscle his way through a tangle of lies to uncover the truth behind a mansion murder.",
              "poster_path": "/woY4fKio0ypWqj2uQj96tCiCRXV.jpg",
              "media_type": "movie",
              "genre_ids": [
                80
              ],
              "popularity": 124.186,
              "release_date": "2023-08-18",
              "video": false,
              "vote_average": 6.313,
              "vote_count": 16
            },
            {
              "adult": false,
              "backdrop_path": "/w2nFc2Rsm93PDkvjY4LTn17ePO0.jpg",
              "id": 614930,
              "title": "Teenage Mutant Ninja Turtles: Mutant Mayhem",
              "original_language": "en",
              "original_title": "Teenage Mutant Ninja Turtles: Mutant Mayhem",
              "overview": "After years of being sheltered from the human world, the Turtle brothers set out to win the hearts of New Yorkers and be accepted as normal teenagers through heroic acts. Their new friend April O'Neil helps them take on a mysterious crime syndicate, but they soon get in over their heads when an army of mutants is unleashed upon them.",
              "poster_path": "/ueO9MYIOHO7M1PiMUeX74uf8fB9.jpg",
              "media_type": "movie",
              "genre_ids": [
                16,
                35,
                28
              ],
              "popularity": 198.035,
              "release_date": "2023-07-31",
              "video": false,
              "vote_average": 7.354,
              "vote_count": 189
            }
          ],
          "total_pages": 1000,
          "total_results": 20000
        }
    """.data(using: .utf8)!
}

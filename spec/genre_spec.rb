require 'spec_helper'

describe Echonest::Genre do
  it 'should accept name for creation' do
    g = Echonest::Genre.new('BNOAEBT3IZYZI6WXI', 'folk rock')

    expect(g.name).to eq 'folk rock'
  end

  describe 'instance methods' do
    context 'with valid api key and name' do
      before :all do
        @genre = Echonest::Genre.new('BNOAEBT3IZYZI6WXI', 'folk rock')
      end

      describe '#artists' do
        it 'returns a list of associated artists' do
          VCR.use_cassette('genre_artists') do
            artists = @genre.artists

            expect(artists[:status][:message]).to eq 'Success'
            expect(artists[:artists]).to include(id: 'ARVHQNN1187B9B9FA3',
                                             name: 'Cat Stevens')
          end
        end
      end

      describe '#profile' do
        it 'returns a profile response given' do
          VCR.use_cassette('genre_profile') do
            profile = @genre.profile

            expect(profile[:status][:message]).to eq 'Success'
            expect(profile[:genres][0][:name]).to eq 'folk rock'
          end
        end
      end

      describe '#similar' do
        it 'returns a list of similar genres' do
          VCR.use_cassette('genre_similar') do
            genres = @genre.similar

            expect(genres[:status][:message]).to eq 'Success'
            expect(genres[:genres]).to include name: 'singer-songwriter', similarity: 0.708333
          end
        end
      end
    end
  end

  describe 'class methods' do
    describe '#list' do
      it 'returns a list of genres given valid api key' do
        VCR.use_cassette('genre_list') do
          genres =  Echonest::Genre.list 'BNOAEBT3IZYZI6WXI'

          expect(genres[:status][:message]).to eq 'Success'
          expect(genres[:genres]).to include name: 'folk rock'
        end
      end
    end

    describe '#search' do
      it 'returns a list of genres related to search term given valid api key' do
        VCR.use_cassette('genre_search') do
          results = Echonest::Genre.search 'BNOAEBT3IZYZI6WXI',
                                           name: 'folk rock'

          expect(results[:status][:message]).to eq 'Success'
          expect(results[:genres]).to include name: 'folk rock'
        end
      end
    end
  end
end

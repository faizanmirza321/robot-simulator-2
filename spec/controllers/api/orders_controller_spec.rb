require 'rails_helper'

RSpec.describe Api::OrdersController, type: :request do
  describe "POST /api/robot/0/orders" do
    context 'for valid command' do
      it 'should return 200 status' do
        post '/api/robot/0/orders', params: { commands: ["PLACE 0,0,NORTH", "MOVE", "REPORT"] }
        expect(response).to have_http_status(200)
      end

      it 'should return correct location' do
        post '/api/robot/0/orders', params: { commands: ["PLACE 0,0,NORTH", "MOVE", "REPORT"] }
        expect(response).to have_http_status(200)

        res_body = JSON.parse(response.body)
        expect(res_body).to eq({ "location" => [0,1,'NORTH'] })
      end

      it 'should return correct location' do
        post '/api/robot/0/orders', params: { commands: ["MOVE", "PLACE 0,2,WEST", "MOVE", "LEFT", "MOVE", "RIGHT", "MOVE", "RIGHT", "REPORT"] }
        expect(response).to have_http_status(200)

        res_body = JSON.parse(response.body)
        expect(res_body).to eq({ "location" => [0,1,'NORTH'] })
      end

      it 'should return correct location' do
        post '/api/robot/0/orders', params: { commands: ["MOVE", "PLACE 0,2,WEST", "MOVE", "RIGHT", "MOVE", "RIGHT", "MOVE", "RIGHT", "REPORT"] }
        expect(response).to have_http_status(200)

        res_body = JSON.parse(response.body)
        expect(res_body).to eq({ "location" => [1,3,'SOUTH'] })
      end

      it 'should return correct location' do
        post '/api/robot/0/orders', params: { commands: ["MOVE", "PLACE 2,2,WEST", "MOVE", "RIGHT", "MOVE", "RIGHT", "MOVE", "RIGHT", "REPORT"] }
        expect(response).to have_http_status(200)

        res_body = JSON.parse(response.body)
        expect(res_body).to eq({ "location" => [2,3,'SOUTH'] })
      end
    end

    context 'for invalid command' do
      it 'should return 200 status' do
        post '/api/robot/0/orders', params: { commands: ["PLACE 0,0,NORH", "MOVE", "REPORT"] }
        expect(response).to have_http_status(422)
      end

      it 'should return correct error message' do
        post '/api/robot/0/orders', params: { commands: ["MOVE", "LEFT", "RIGHT", "REPORT"] }
        expect(response).to have_http_status(422)

        res_body = JSON.parse(response.body)
        expect(res_body).to eq({ "error" => "Robot not placed" })
      end

      it 'should return correct error message' do
        post '/api/robot/0/orders', params: { commands: ["PLACE 0,0,NORH", "MOVE", "REPORT"] }
        expect(response).to have_http_status(422)

        res_body = JSON.parse(response.body)
        expect(res_body).to eq({ "error" => "Invalid direction: 'NORH'" })
      end

      it 'should return correct error message' do
        post '/api/robot/0/orders', params: { commands: ["PLAC 0,0,NORTH", "MOVE", "REPORT"] }
        expect(response).to have_http_status(422)

        res_body = JSON.parse(response.body)
        expect(res_body).to eq({ "error" => "Invalid command: 'PLAC 0,0,NORTH'" })
      end

      it 'should return correct error message' do
        post '/api/robot/0/orders', params: { commands: ["PLACE 0,0,NORTH", "STAND", "REPORT"] }
        expect(response).to have_http_status(422)

        res_body = JSON.parse(response.body)
        expect(res_body).to eq({ "error" => "Invalid command: 'STAND'" })
      end
    end
  end
end

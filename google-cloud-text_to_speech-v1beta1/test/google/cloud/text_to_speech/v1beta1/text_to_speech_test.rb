# frozen_string_literal: true

# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "simplecov"
require "minitest/autorun"

require "gapic/grpc/service_stub"

require "google/cloud/texttospeech/v1beta1/cloud_tts_pb"
require "google/cloud/texttospeech/v1beta1/cloud_tts_services_pb"
require "google/cloud/text_to_speech/v1beta1/text_to_speech"

class Google::Cloud::TextToSpeech::V1beta1::TextToSpeech::ClientTest < Minitest::Test
  class ClientStub
    attr_accessor :call_rpc_count, :requests

    def initialize response, operation, &block
      @response = response
      @operation = operation
      @block = block
      @call_rpc_count = 0
      @requests = []
    end

    def call_rpc *args
      @call_rpc_count += 1

      @requests << @block&.call(*args)

      yield @response, @operation if block_given?

      @response
    end
  end

  def test_list_voices
    # Create GRPC objects.
    grpc_response = Google::Cloud::TextToSpeech::V1beta1::ListVoicesResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    language_code = "hello world"

    list_voices_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :list_voices, name
      assert_kind_of Google::Cloud::TextToSpeech::V1beta1::ListVoicesRequest, request
      assert_equal "hello world", request.language_code
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, list_voices_client_stub do
      # Create client
      client = Google::Cloud::TextToSpeech::V1beta1::TextToSpeech::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.list_voices({ language_code: language_code }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.list_voices language_code: language_code do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.list_voices Google::Cloud::TextToSpeech::V1beta1::ListVoicesRequest.new(language_code: language_code) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.list_voices({ language_code: language_code }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.list_voices Google::Cloud::TextToSpeech::V1beta1::ListVoicesRequest.new(language_code: language_code), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, list_voices_client_stub.call_rpc_count
    end
  end

  def test_synthesize_speech
    # Create GRPC objects.
    grpc_response = Google::Cloud::TextToSpeech::V1beta1::SynthesizeSpeechResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    input = {}
    voice = {}
    audio_config = {}

    synthesize_speech_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :synthesize_speech, name
      assert_kind_of Google::Cloud::TextToSpeech::V1beta1::SynthesizeSpeechRequest, request
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Cloud::TextToSpeech::V1beta1::SynthesisInput), request.input
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Cloud::TextToSpeech::V1beta1::VoiceSelectionParams), request.voice
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Cloud::TextToSpeech::V1beta1::AudioConfig), request.audio_config
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, synthesize_speech_client_stub do
      # Create client
      client = Google::Cloud::TextToSpeech::V1beta1::TextToSpeech::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.synthesize_speech({ input: input, voice: voice, audio_config: audio_config }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.synthesize_speech input: input, voice: voice, audio_config: audio_config do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.synthesize_speech Google::Cloud::TextToSpeech::V1beta1::SynthesizeSpeechRequest.new(input: input, voice: voice, audio_config: audio_config) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.synthesize_speech({ input: input, voice: voice, audio_config: audio_config }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.synthesize_speech Google::Cloud::TextToSpeech::V1beta1::SynthesizeSpeechRequest.new(input: input, voice: voice, audio_config: audio_config), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, synthesize_speech_client_stub.call_rpc_count
    end
  end

  def test_configure
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure

    client = block_config = config = nil
    Gapic::ServiceStub.stub :new, nil do
      client = Google::Cloud::TextToSpeech::V1beta1::TextToSpeech::Client.new do |config|
        config.credentials = grpc_channel
      end
    end

    config = client.configure do |c|
      block_config = c
    end

    assert_same block_config, config
    assert_kind_of Google::Cloud::TextToSpeech::V1beta1::TextToSpeech::Client::Configuration, config
  end
end

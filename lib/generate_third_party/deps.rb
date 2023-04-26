# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

module Artichoke
  module GenerateThirdParty
    class Dependency < T::Struct
      extend T::Sig

      const :name, String
      const :version, String
      const :url, T.nilable(String)
      const :description, T.nilable(String)
      const :license, String
      const :license_id, String
      const :license_text, String
    end

    module ExternalDeps
      MRUBY = Dependency.new(
        name: 'mruby',
        version: '3.2.0',
        url: 'https://github.com/mruby/mruby',
        description: 'Lightweight Ruby',
        license: 'MIT License',
        license_id: 'MIT',
        license_text: <<~LICENSE
          Copyright (c) 2010-2023 mruby developers

          Permission is hereby granted, free of charge, to any person obtaining a
          copy of this software and associated documentation files (the "Software"),
          to deal in the Software without restriction, including without limitation
          the rights to use, copy, modify, merge, publish, distribute, sublicense,
          and/or sell copies of the Software, and to permit persons to whom the
          Software is furnished to do so, subject to the following conditions:

          The above copyright notice and this permission notice shall be included in
          all copies or substantial portions of the Software.

          THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
          IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
          FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
          AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
          LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
          FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
          DEALINGS IN THE SOFTWARE.
        LICENSE
      )

      ONIGURUMA = Dependency.new(
        name: 'oniguruma',
        version: '6.9.8',
        url: 'https://github.com/kkos/oniguruma',
        description: 'regular expression library',
        license: '2-Clause BSD License',
        license_id: 'BSD-2-Clause',
        license_text: <<~LICENSE
          Oniguruma LICENSE
          -----------------

          Copyright (c) 2002-2021  K.Kosako  <kkosako0@gmail.com>
          All rights reserved.

          Redistribution and use in source and binary forms, with or without
          modification, are permitted provided that the following conditions
          are met:
          1. Redistributions of source code must retain the above copyright
             notice, this list of conditions and the following disclaimer.
          2. Redistributions in binary form must reproduce the above copyright
             notice, this list of conditions and the following disclaimer in the
             documentation and/or other materials provided with the distribution.

          THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
          ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
          IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
          ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
          FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
          DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
          OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
          HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
          LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
          OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
          SUCH DAMAGE.
        LICENSE
      )
    end
  end
end

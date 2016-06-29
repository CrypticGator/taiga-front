###
# Copyright (C) 2014-2016 Taiga Agile LLC <taiga@taiga.io>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#
# File: card-slideshow.controller.spec.coffee
###

describe "CardSlideshow", ->
    $provide = null
    $controller = null
    mocks = {}

    _inject = ->
        inject (_$controller_) ->
            $controller = _$controller_

    _setup = ->
        _inject()

    beforeEach ->
        module "taigaComponents"

        _setup()

    it "get only images", () ->
        ctrl = $controller("CardSlideshow")

        ctrl.attachments = Immutable.fromJS([
            {thumbnail_card_url: "xx"},
            {},
            {thumbnail_card_url: "yy"}
        ])

        images = ctrl.getImages()

        expect(images.size).to.be.eql(2)

    it "hasPagination", () ->
        ctrl = $controller("CardSlideshow")

        ctrl.attachments = Immutable.fromJS([
            {thumbnail_card_url: "xx"},
            {},
            {thumbnail_card_url: "yy"}
        ])

        pagination = ctrl.hasPagination()

        expect(pagination).to.be.true

        ctrl.attachments = Immutable.List()

        pagination = ctrl.hasPagination()

        expect(pagination).to.be.false

    it "next image", () ->
        ctrl = $controller("CardSlideshow")

        ctrl.attachments = Immutable.fromJS([
            {id: 1, thumbnail_card_url: "xx"},
            {id: 2},
            {id: 3, thumbnail_card_url: "yy"},
            {id: 4, thumbnail_card_url: "zz"}
        ])

        ctrl.next()
        expect(ctrl.index).to.be.equal(2)
        ctrl.next()
        expect(ctrl.index).to.be.equal(3)
        ctrl.next()
        expect(ctrl.index).to.be.equal(0)

    it "previous image", () ->
        ctrl = $controller("CardSlideshow")

        ctrl.attachments = Immutable.fromJS([
            {id: 1, thumbnail_card_url: "xx"},
            {id: 2},
            {id: 3, thumbnail_card_url: "yy"},
            {id: 4, thumbnail_card_url: "zz"}
        ])

        ctrl.previous()
        expect(ctrl.index).to.be.equal(3)
        ctrl.previous()
        expect(ctrl.index).to.be.equal(2)
        ctrl.previous()
        expect(ctrl.index).to.be.equal(0)

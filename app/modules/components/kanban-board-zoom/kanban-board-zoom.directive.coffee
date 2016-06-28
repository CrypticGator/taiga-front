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
# File: kanban-board-zoom.directive.coffee
###

KanbanBoardZoomDirective = (storage) ->
    link = (scope, el, attrs, ctrl) ->
        scope.zoomIndex = storage.get("kanban_zoom") or 0

        zooms = [
            ["ref"],
            ["subject"],
            ["owner", "tags", "extra_info", "unfold"],
            ["attachments"],
            ["related_tasks"]
        ]

        getZoomView = (zoomIndex = 0) ->
            if storage.get("kanban_zoom") != zoomIndex
                storage.set("kanban_zoom", zoomIndex)

            return _.reduce zooms, (result, value, key) ->
                if key <= zoomIndex
                    result = result.concat(value)

                return result

        scope.$watch 'zoomIndex', (zoomLevel) ->
            zoom = getZoomView(zoomLevel)
            scope.onZoomChange({zoomLevel: zoomLevel, zoom: zoom})

    return {
        scope: {
            onZoomChange: "&"
        },
        template: """
        <tg-board-zoom
            class="board-zoom"
            value="zoomIndex"
        ></tg-board-zoom>
        """,
        link: link
    }

angular.module('taigaComponents').directive("tgKanbanBoardZoom", ["$tgStorage", KanbanBoardZoomDirective])

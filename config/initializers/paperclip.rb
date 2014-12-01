# Hack this monkey patch into an initializer for convenience.
# TODO: Move into lib or make elegant some way.
module Paperclip
  class ContentTypeDetector
    # The content-type detection strategy is as follows:
    #
    # 1. Blank/Empty files: If there's no filename or the file is empty,
    #    provide a sensible default (application/octet-stream or inode/x-empty)
    #
    # 2. Calculated match: Return the first result that is found by both the
    #    `file` command and MIME::Types.
    #
    # 3. Standard types: Return the first standard (without an x- prefix) entry
    #    in MIME::Types
    #
    # 4. Experimental types: If there were no standard types in MIME::Types
    #    list, try to return the first experimental one
    #
    # 5. Raw `file` command: Just use the output of the `file` command raw, or
    #    a sensible default. This is cached from Step 2.

    # Returns a String describing the file's content type
    def detect
      if blank_name?
        SENSIBLE_DEFAULT
      elsif empty_file?
        EMPTY_TYPE
      elsif calculated_type_matches.any?
        calculated_type_matches.first
      elsif possible_types.any?
        possible_types.first
      else
        type_from_file_command || SENSIBLE_DEFAULT
      end.to_s
    end
  end
end
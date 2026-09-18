# frozen_string_literal: true

module CheckoutSdk
  module Inventory
    # Request body for PUT /inventory/{variant_id}/product (Beta). Mirrors swagger
    # `InventorySetProductRequest`, the "product knowledge" merchandising metadata used by AI
    # agents. Shares its optional fields with the `InventoryProductKnowledge` response schema,
    # which this SDK does not model as a class because responses are returned as Hash (see
    # {InventoryClient}).
    #
    # @!attribute title
    #   @return [String] The product title. [Required] max 512 characters.
    # @!attribute description
    #   @return [String] The product description. [Required] max 4000 characters.
    # @!attribute product_url
    #   @return [String] The URL of the product page. [Required] max 2048 characters.
    # @!attribute image_url
    #   @return [String] The URL of the primary product image. [Required] max 2048 characters.
    # @!attribute additional_image_urls
    #   @return [Array<String>] Additional product image URLs. [Optional]
    # @!attribute video_url
    #   @return [String] The URL of a product video. [Optional]
    # @!attribute model_3d_url
    #   @return [String] The URL of a 3D model of the product. [Optional]
    # @!attribute sku
    #   @return [String] The merchant's SKU for the variant. [Optional] max 128 characters.
    # @!attribute gtin
    #   @return [String] The Global Trade Item Number. [Optional]
    # @!attribute mpn
    #   @return [String] The Manufacturer Part Number. [Optional]
    # @!attribute brand
    #   @return [String] The product's brand. [Optional]
    # @!attribute category
    #   @return [String] The product's category. [Optional]
    # @!attribute price
    #   @return [InventoryMoney] The product's list price. [Optional] When set together with
    #     sale_price, sale_price must share its currency and be less than or equal to it.
    # @!attribute sale_price
    #   @return [InventoryMoney] The product's discounted price. [Optional] Must share price's
    #     currency and be less than or equal to it.
    # @!attribute sale_price_starts_at
    #   @return [Time] When the sale price becomes active. [Optional] Pairs with sale_price.
    #     Format: date-time (RFC 3339).
    # @!attribute sale_price_ends_at
    #   @return [Time] When the sale price stops being active. [Optional] Pairs with
    #     sale_price. Format: date-time (RFC 3339).
    # @!attribute group_id
    #   @return [String] Identifies a group of related variants (e.g. the same product in
    #     different colors/sizes). [Optional] Per spec (not a formal schema constraint), when
    #     set, color and size are both required.
    # @!attribute group_title
    #   @return [String] The title shared by the variant group. [Optional]
    # @!attribute color
    #   @return [String] The variant's color. [Optional] Required when group_id is set (spec
    #     text, not a formal constraint).
    # @!attribute size
    #   @return [String] The variant's size. [Optional] Required when group_id is set (spec
    #     text, not a formal constraint).
    # @!attribute size_system
    #   @return [String] The sizing system the size value uses. [Optional]
    # @!attribute gender
    #   @return [String] The target gender for the product. [Optional]
    # @!attribute condition
    #   @return [String] The product's condition. [Optional] Enum: "new" "used" "refurbished".
    #     Exact lowercase match. Default: "new".
    # @!attribute material
    #   @return [String] The product's material. [Optional]
    # @!attribute age_group
    #   @return [String] The target age group for the product. [Optional]
    # @!attribute length
    #   @return [Float] The product's length. [Optional]
    # @!attribute width
    #   @return [Float] The product's width. [Optional]
    # @!attribute height
    #   @return [Float] The product's height. [Optional]
    # @!attribute dimension_unit
    #   @return [String] The unit used for length, width and height. [Optional]
    # @!attribute weight
    #   @return [Float] The product's weight. [Optional]
    # @!attribute weight_unit
    #   @return [String] The unit used for weight. [Optional]
    # @!attribute expiration_date
    #   @return [Time] The product's expiration date. [Optional] Format: date-time
    #     (RFC 3339).
    # @!attribute harmonized_system_code
    #   @return [String] The Harmonized System code used for customs. [Optional]
    # @!attribute country_of_origin
    #   @return [String] The product's country of origin. [Optional] 2-letter ISO 3166-1
    #     alpha-2 code.
    # @!attribute seller_name
    #   @return [String] The seller's name. [Optional]
    # @!attribute seller_url
    #   @return [String] The seller's URL. [Optional]
    # @!attribute seller_privacy_policy
    #   @return [String] The URL of the seller's privacy policy. [Optional]
    # @!attribute seller_tos
    #   @return [String] The URL of the seller's terms of service. [Optional]
    class InventorySetProductRequest
      attr_accessor :title,
                    :description,
                    :product_url,
                    :image_url,
                    :additional_image_urls,
                    :video_url,
                    :model_3d_url,
                    :sku,
                    :gtin,
                    :mpn,
                    :brand,
                    :category,
                    :price,
                    :sale_price,
                    :sale_price_starts_at,
                    :sale_price_ends_at,
                    :group_id,
                    :group_title,
                    :color,
                    :size,
                    :size_system,
                    :gender,
                    :condition,
                    :material,
                    :age_group,
                    :length,
                    :width,
                    :height,
                    :dimension_unit,
                    :weight,
                    :weight_unit,
                    :expiration_date,
                    :harmonized_system_code,
                    :country_of_origin,
                    :seller_name,
                    :seller_url,
                    :seller_privacy_policy,
                    :seller_tos
    end
  end
end

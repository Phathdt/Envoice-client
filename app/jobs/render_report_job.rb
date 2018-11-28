class RenderReportJob < ApplicationJob
  queue_as :default

  def perform(invoice)
    ActiveRecord::Base.transaction do
      html = InvoicesController.render :preview, layout: false, assigns: { invoice: invoice, company: Company.first }
      kit = IMGKit.new(html, quality: 50)
      file = kit.to_file('report.jpg')
      invoice.image.attach(io: File.open("report.jpg"), filename: "report.jpg", content_type: "image/jpg")

      kit = PDFKit.new(html, page_size: 'letter', zoom: 4)
      file = kit.to_file('report.pdf')
      invoice.pdf.attach(io: File.open("report.pdf"), filename: "report.pdf")
    end
  end
end
